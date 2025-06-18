import 'package:auto_route/auto_route.dart' hide CupertinoPageRoute;
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/auto_router_setup/auto_router.gr.dart';
import 'package:flutter_app/src/core/utils/mapper/date_time_mapper.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/features/home/presentation/pages/create_record_page.dart';
import 'package:flutter_app/src/features/home/presentation/pages/reminders_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/src/core/providers/health_record_provider.dart';
import 'package:flutter_app/src/core/entities/health_record.dart';
import 'package:flutter_app/src/core/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/src/core/utils/glucose_calculator.dart';
import 'package:flutter_app/src/features/home/presentation/constants/history_page_constants.dart';
import 'package:flutter_app/src/features/home/presentation/widgets/health_record_card.dart';
import 'package:flutter_app/src/features/home/presentation/widgets/quick_add_menu.dart';
import 'package:flutter_app/src/features/home/presentation/widgets/health_stats_section.dart';
import 'package:flutter_app/src/features/home/presentation/widgets/tag_selector.dart';
import 'package:flutter_app/src/features/home/presentation/widgets/type_selector.dart';

@RoutePage()
class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage> with WidgetsBindingObserver {
  int _selectedSegment = 0;
  String? _selectedTag;
  String? _selectedType;
  bool _showRecordMenu = false;
  late SharedPreferences _prefs;
  late ValueNotifier<bool> _hideQuickAddButtonNotifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializePrefs();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HealthRecordProvider>().loadAllRecords();
    });
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _hideQuickAddButtonNotifier =
        ValueNotifier<bool>(_prefs.getBool('hide_quick_add_button') ?? false);
    _hideQuickAddButtonNotifier.addListener(_updateRecordMenuVisibility);
  }

  void _updateRecordMenuVisibility() {
    if (mounted) {
      setState(() {
        _showRecordMenu = false;
      });
    }
  }

  @override
  void dispose() {
    _hideQuickAddButtonNotifier.removeListener(_updateRecordMenuVisibility);
    _hideQuickAddButtonNotifier.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<HealthRecordProvider>().loadAllRecords();
    }
  }

  Map<int, Widget> _buildSegmentOptions() {
    return {
      for (var i = 0; i < HistoryPageConstants.segmentLabels.length; i++)
        i: Text(
          HistoryPageConstants.segmentLabels[i],
          style: smallPoppinsRegular.copyWith(
            color: _selectedSegment != i ? white : primary6,
          ),
        ),
    };
  }

  Map<String, String> _calculateGlucoseStats(
      List<HealthRecord> records, int days) {
    final now = DateTime.now();
    final endDate = now;
    final startDate = now.subtract(Duration(days: days));
    final priorEndDate = startDate;
    final priorStartDate = priorEndDate.subtract(Duration(days: days));

    final currentPeriodRecords = records.where((record) {
      final date = record.date ?? DateTime.now();
      return date.isAfter(startDate) && date.isBefore(endDate);
    }).toList();

    final priorPeriodRecords = records.where((record) {
      final date = record.date ?? DateTime.now();
      return date.isAfter(priorStartDate) && date.isBefore(priorEndDate);
    }).toList();

    final currentGlucoseValues = currentPeriodRecords
        .map((record) => record.maybeWhen(
              glucose: (id, glucose, tags, date, note) => glucose,
              orElse: () => null,
            ))
        .where((value) => value != null)
        .map((value) => value!)
        .toList();

    final priorGlucoseValues = priorPeriodRecords
        .map((record) => record.maybeWhen(
              glucose: (id, glucose, tags, date, note) => glucose,
              orElse: () => null,
            ))
        .where((value) => value != null)
        .map((value) => value!)
        .toList();

    final currentAvg = currentGlucoseValues.isEmpty
        ? '---'
        : (currentGlucoseValues.reduce((a, b) => a + b) /
                currentGlucoseValues.length)
            .round()
            .toString();
    final priorAvg = priorGlucoseValues.isEmpty
        ? '---'
        : (priorGlucoseValues.reduce((a, b) => a + b) /
                priorGlucoseValues.length)
            .round()
            .toString();
    final low = currentGlucoseValues.isEmpty
        ? '---'
        : currentGlucoseValues.reduce((a, b) => a < b ? a : b).toString();
    final high = currentGlucoseValues.isEmpty
        ? '---'
        : currentGlucoseValues.reduce((a, b) => a > b ? a : b).toString();

    return {
      'avg': currentAvg,
      'priorAvg': priorAvg,
      'low': low,
      'high': high,
    };
  }

  List<double> _getCurrentGlucoseValues() {
    final now = DateTime.now();
    final days = HistoryPageConstants.segmentDayValues[_selectedSegment];
    final startDate = now.subtract(Duration(days: days));

    return context
        .read<HealthRecordProvider>()
        .records
        .where((record) => record.maybeWhen<bool>(
              glucose: (id, glucose, tags, date, note) =>
                  date != null && date.isAfter(startDate) && date.isBefore(now),
              orElse: () => false,
            ))
        .map((record) => record.maybeWhen<double>(
              glucose: (id, glucose, tags, date, note) => glucose,
              orElse: () => 0.0,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final preferencesService = context.watch<PreferencesService>();
    final hideQuickAddButton = preferencesService.hideQuickAddButton;
    final currentGlucoseValues = _getCurrentGlucoseValues();

    return CupertinoPageScaffold(
      backgroundColor: primary1,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'History',
          style: poppinsMedium.copyWith(color: white, fontSize: 18),
        ),
        backgroundColor: primary1.withOpacity(1.0),
        leading: CupertinoButton(
          padding: const EdgeInsets.all(4),
          child: Icon(CupertinoIcons.profile_circled, color: white, size: 24),
          onPressed: () {},
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoButton(
              padding: const EdgeInsets.all(4),
              child: Icon(CupertinoIcons.bell, color: white, size: 24),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => const RemindersPage(),
                    maintainState: true,
                  ),
                );
              },
            ),
            CupertinoButton(
              padding: const EdgeInsets.all(4),
              child: Icon(CupertinoIcons.add, color: white, size: 24),
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) =>
                        const CreateRecordPage(initialType: 'Glucose'),
                    maintainState: true,
                  ),
                );
              },
            )
          ],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              color: white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    color: primary1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CupertinoSegmentedControl<int>(
                          children: _buildSegmentOptions(),
                          onValueChanged: (int value) {
                            setState(() {
                              _selectedSegment = value;
                            });
                          },
                          groupValue: _selectedSegment,
                          unselectedColor: primary6,
                          selectedColor: white,
                          borderColor: CupertinoColors.transparent,
                          padding: const EdgeInsets.all(24),
                        ),
                        Consumer<HealthRecordProvider>(
                          builder: (context, provider, child) {
                            final stats = _calculateGlucoseStats(
                              provider.records,
                              HistoryPageConstants
                                  .segmentDayValues[_selectedSegment],
                            );
                            return HealthStatsSection(stats: stats);
                          },
                        ),
                        const SizedBox(height: 8),
                        FutureBuilder<double>(
                          future: GlucoseCalculator.calculateEstimatedA1C(
                              currentGlucoseValues),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.waiting ||
                                snapshot.data == null ||
                                snapshot.data == 0.0) {
                              return const SizedBox.shrink();
                            }
                            return Container(
                              width: double.infinity,
                              color: primary1,
                              child: Center(
                                child: Container(
                                  width: 100,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 6,
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'est. A1C: ${snapshot.data?.toStringAsFixed(2) == '0.00' ? 'N/A' : snapshot.data?.toStringAsFixed(2)}',
                                    style: poppinsRegular.copyWith(
                                      fontSize: 14,
                                      color: primary6,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CupertinoButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                _selectedTag == null ? 'Tags' : _selectedTag!,
                                style: poppinsRegular.copyWith(
                                  fontSize: 14,
                                  color: white,
                                ),
                              ),
                              onPressed: () => _showTagSelector(context),
                            ),
                            CupertinoButton(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'All Logs',
                                style: poppinsRegular.copyWith(
                                  fontSize: 14,
                                  color: white,
                                ),
                              ),
                              onPressed: () => _showTypeSelector(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: CupertinoColors.systemGroupedBackground,
                      child: _buildHealthRecordsList(),
                    ),
                  ),
                ],
              ),
            ),
            if (!hideQuickAddButton)
              Positioned(
                right: 16,
                bottom: 16,
                child: QuickAddMenu(
                  isVisible: _showRecordMenu,
                  onToggle: () {
                    setState(() {
                      _showRecordMenu = !_showRecordMenu;
                    });
                  },
                  onRecordTypeSelected: (type) {
                    setState(() => _showRecordMenu = false);
                    context.router.push(CreateRecordRoute(initialType: type));
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showTagSelector(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => TagSelector(
        selectedTag: _selectedTag,
        onTagSelected: (tag) {
          setState(() {
            _selectedTag = tag;
          });
        },
      ),
    );
  }

  void _showTypeSelector(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => TypeSelector(
        selectedType: _selectedType,
        onTypeSelected: (type) {
          setState(() {
            _selectedType = type;
          });
        },
      ),
    );
  }

  Widget _buildHealthRecordsList() {
    return Consumer<HealthRecordProvider>(
      builder: (context, provider, child) {
        var records = provider.records;

        if (_selectedType != null) {
          records = records
              .where((record) =>
                  record.maybeWhen(
                    glucose: (id, glucose, tags, date, note) => 'Glucose',
                    weight: (id, weight, tags, date, note) => 'Weight',
                    bloodPressure: (id, systolic, diastolic, heartRate, tags,
                            date, note) =>
                        'Blood Pressure',
                    insulin: (id, units, insulinName, tags, date, note) =>
                        'Insulin',
                    medication: (id, medicationName, medicationTime, tags, date,
                            note) =>
                        'Medications',
                    carbs: (id, carbohydrates, food, fat, protein, tags, date,
                            note) =>
                        'Carbs',
                    temperature: (id, temperature, tags, date, note) =>
                        'Temperature',
                    a1c: (id, a1c, tags, date, note) => 'A1C',
                    exercise: (id, exerciseType, duration, tags, date, note) =>
                        'Exercise',
                    oxygen: (id, oxygen, heartRate, tags, date, note) =>
                        'Oxygen',
                    note: (id, tags, date, note) => 'Notes',
                    ketones: (id, ketones, tags, date, note) => 'Ketones',
                    orElse: () => '',
                  ) ==
                  _selectedType)
              .toList();
        }

        if (_selectedTag != null) {
          records = records
              .where((record) => record.tags.contains(_selectedTag))
              .toList();
        }

        if (records.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.doc_text, size: 48, color: grey),
                const SizedBox(height: 16),
                Text(
                  'No records found',
                  style: poppinsRegular.copyWith(
                    fontSize: 16,
                    color: CupertinoColors.systemGrey,
                  ),
                ),
              ],
            ),
          );
        }

        final groupedRecords = <DateTime, List<HealthRecord>>{};
        for (final record in records) {
          final date = record.date ?? DateTime.now();
          final day = DateTime(date.year, date.month, date.day);
          groupedRecords.putIfAbsent(day, () => []).add(record);
        }

        final sortedDays = groupedRecords.keys.toList()
          ..sort((a, b) => b.compareTo(a));

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: sortedDays.length,
          itemBuilder: (context, index) {
            final day = sortedDays[index];
            final dayRecords = groupedRecords[day]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    formatDayHeader(day),
                    style: poppinsMedium.copyWith(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ),
                ...dayRecords.map((record) => HealthRecordCard(
                      record: record,
                      onTap: () {
                        final recordType = record.maybeWhen(
                          glucose: (id, glucose, tags, date, note) => 'Glucose',
                          weight: (id, weight, tags, date, note) => 'Weight',
                          bloodPressure: (id, systolic, diastolic, heartRate,
                                  tags, date, note) =>
                              'Blood Pressure',
                          insulin: (id, units, insulinName, tags, date, note) =>
                              'Insulin',
                          medication: (id, medicationName, medicationTime, tags,
                                  date, note) =>
                              'Medications',
                          carbs: (id, carbohydrates, food, fat, protein, tags,
                                  date, note) =>
                              'Carbs',
                          temperature: (id, temperature, tags, date, note) =>
                              'Temperature',
                          a1c: (id, a1c, tags, date, note) => 'A1C',
                          exercise:
                              (id, exerciseType, duration, tags, date, note) =>
                                  'Exercise',
                          oxygen: (id, oxygen, heartRate, tags, date, note) =>
                              'Oxygen',
                          note: (id, tags, date, note) => 'Notes',
                          ketones: (id, ketones, tags, date, note) => 'Ketones',
                          orElse: () => '',
                        );

                        context.router.push(CreateRecordRoute(
                          initialType: recordType,
                          record: record,
                        ));
                      },
                    )),
              ],
            );
          },
        );
      },
    );
  }
}
