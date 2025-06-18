import 'package:auto_route/auto_route.dart' hide CupertinoPageRoute;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/core/providers/health_record_provider.dart';
import 'package:flutter_app/src/core/entities/health_record.dart';
import 'package:flutter_app/src/core/services/preferences_service.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_app/src/core/utils/glucose_calculator.dart';

@RoutePage()
class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  State<StatefulWidget> createState() => _GraphPageState();
}

class _GraphPageState extends State<GraphPage> {
  int _selectedSegment = 2; // Default to 7D
  String? _selectedTag;
  String? _selectedType = 'Glucose';

  Map<int, Widget> _buildSegmentOptions() {
    return {
      0: Text('3D',
          style: poppinsRegular.copyWith(
              fontSize: 14,
              color: _selectedSegment != 0 ? white : primary6,
              decoration: TextDecoration.none)),
      1: Text('7D',
          style: poppinsRegular.copyWith(
              fontSize: 14,
              color: _selectedSegment != 1 ? white : primary6,
              decoration: TextDecoration.none)),
      2: Text('14D',
          style: poppinsRegular.copyWith(
              fontSize: 14,
              color: _selectedSegment != 2 ? white : primary6,
              decoration: TextDecoration.none)),
      3: Text('30D',
          style: poppinsRegular.copyWith(
              fontSize: 14,
              color: _selectedSegment != 3 ? white : primary6,
              decoration: TextDecoration.none)),
      4: Text('90D',
          style: poppinsRegular.copyWith(
              fontSize: 14,
              color: _selectedSegment != 4 ? white : primary6,
              decoration: TextDecoration.none)),
      5: Text('180D',
          style: poppinsRegular.copyWith(
              fontSize: 14,
              color: _selectedSegment != 5 ? white : primary6,
              decoration: TextDecoration.none)),
    };
  }

  int _getDaysForSegment(int segment) {
    switch (segment) {
      case 0:
        return 3;
      case 1:
        return 7;
      case 2:
        return 14;
      case 3:
        return 30;
      case 4:
        return 90;
      case 5:
        return 180;
      default:
        return 7;
    }
  }

  List<FlSpot> _getChartData(List<HealthRecord> records) {
    if (_selectedType == null) return [];

    final now = DateTime.now();
    final startDate =
        now.subtract(Duration(days: _getDaysForSegment(_selectedSegment)));

    var filteredRecords = records.where((record) {
      final date = record.date ?? DateTime.now();
      return date.isAfter(startDate) && date.isBefore(now);
    }).toList();

    // Filter by type
    filteredRecords = filteredRecords.where((record) {
      return record.when(
        glucose: (id, glucose, tags, date, note) =>
            _selectedType == 'Glucose' ? true : false,
        weight: (id, weight, tags, date, note) =>
            _selectedType == 'Weight' ? true : false,
        bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) =>
            _selectedType == 'Blood Pressure' ? true : false,
        insulin: (id, units, insulinName, tags, date, note) =>
            _selectedType == 'Insulin' ? true : false,
        medication: (id, medicationName, medicationTime, tags, date, note) =>
            false,
        carbs: (id, carbohydrates, food, fat, protein, tags, date, note) =>
            _selectedType == 'Carbs' ? true : false,
        temperature: (id, temperature, tags, date, note) =>
            _selectedType == 'Temperature' ? true : false,
        a1c: (id, a1c, tags, date, note) =>
            _selectedType == 'A1C' ? true : false,
        exercise: (id, exerciseType, duration, tags, date, note) => false,
        oxygen: (id, oxygen, heartRate, tags, date, note) =>
            _selectedType == 'Oxygen' ? true : false,
        note: (id, tags, date, note) => false,
        ketones: (id, ketones, tags, date, note) =>
            _selectedType == 'Ketones' ? true : false,
      );
    }).toList();

    // Filter by tag
    if (_selectedTag != null) {
      filteredRecords = filteredRecords
          .where((record) => record.tags.contains(_selectedTag))
          .toList();
    }

    // Sort by date
    filteredRecords.sort((a, b) =>
        (a.date ?? DateTime.now()).compareTo(b.date ?? DateTime.now()));

    // Convert to chart points
    return filteredRecords.map((record) {
      final date = record.date ?? DateTime.now();
      final daysFromStart = date.difference(startDate).inDays.toDouble();

      final value = record.when(
        glucose: (id, glucose, tags, date, note) => glucose.toDouble(),
        weight: (id, weight, tags, date, note) => weight,
        bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) =>
            systolic.toDouble(),
        insulin: (id, units, insulinName, tags, date, note) => units,
        medication: (id, medicationName, medicationTime, tags, date, note) =>
            0.0,
        carbs: (id, carbohydrates, food, fat, protein, tags, date, note) =>
            carbohydrates.toDouble(),
        temperature: (id, temperature, tags, date, note) => temperature,
        a1c: (id, a1c, tags, date, note) => a1c,
        exercise: (id, exerciseType, duration, tags, date, note) => 0.0,
        oxygen: (id, oxygen, heartRate, tags, date, note) => oxygen.toDouble(),
        note: (id, tags, date, note) => 0.0,
        ketones: (id, ketones, tags, date, note) => ketones,
      );

      return FlSpot(daysFromStart, value);
    }).toList();
  }

  Future<double> _calculateA1C(List<HealthRecord> records) async {
    if (_selectedType != 'Glucose') return 0.0;

    final glucoseValues = records
        .where((record) => record.maybeWhen<bool>(
              glucose: (id, glucose, tags, date, note) => true,
              orElse: () => false,
            ))
        .map((record) => record.maybeWhen<double>(
              glucose: (id, glucose, tags, date, note) => glucose.toDouble(),
              orElse: () => 0.0,
            ))
        .toList();

    return await GlucoseCalculator.calculateEstimatedA1C(glucoseValues);
  }

  @override
  Widget build(BuildContext context) {
    final prefsService = Provider.of<PreferencesService>(context);
    final nonFastingMin = prefsService.nonFastingMin;
    final nonFastingMax = prefsService.nonFastingMax;

    return CupertinoPageScaffold(
      backgroundColor: white,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primary1,
        middle: Text(
          'Graph',
          style: poppinsMedium.copyWith(color: white, fontSize: 18),
        ),
        leading: CupertinoButton(
          padding: const EdgeInsets.all(4),
          child: Icon(
            CupertinoIcons.profile_circled,
            size: 24,
            color: white,
          ),
          onPressed: () {},
        ),
        trailing: CupertinoButton(
          padding: const EdgeInsets.all(4),
          child: Text(
            'Save',
            style: poppinsRegular.copyWith(color: white),
          ),
          onPressed: () {
            // TODO: Implement save functionality
          },
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8),
              color: primary1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Tags Filter
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      _selectedTag ?? 'Tags',
                      style: poppinsRegular.copyWith(
                        fontSize: 14,
                        color: white,
                      ),
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          color: CupertinoColors.systemBackground,
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemBackground,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: CupertinoColors.systemGrey
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Select Tags',
                                  style: poppinsRegular.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Consumer<HealthRecordProvider>(
                                  builder: (context, provider, child) {
                                    final allTags = provider.records
                                        .expand((record) => record.tags)
                                        .toSet()
                                        .toList()
                                      ..sort();

                                    allTags.insert(0, 'All Tags');

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: allTags.length,
                                      itemBuilder: (context, index) {
                                        final tag = allTags[index];
                                        return CupertinoListTile(
                                          title: Text(tag),
                                          trailing: _selectedTag == tag
                                              ? Icon(CupertinoIcons.check_mark,
                                                  color: primary1)
                                              : null,
                                          onTap: () {
                                            setState(() {
                                              _selectedTag = tag == 'All Tags'
                                                  ? null
                                                  : tag;
                                            });
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  // Type Filter
                  CupertinoButton(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      _selectedType!,
                      style: poppinsRegular.copyWith(
                        fontSize: 14,
                        color: white,
                      ),
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (context) => Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          color: CupertinoColors.systemBackground,
                          child: Column(
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: CupertinoColors.systemBackground,
                                  border: Border(
                                    bottom: BorderSide(
                                      color: CupertinoColors.systemGrey
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Select Type',
                                  style: poppinsRegular.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Consumer<HealthRecordProvider>(
                                  builder: (context, provider, child) {
                                    final recordTypes = provider.records
                                        .map((record) => record.when(
                                              glucose: (id, glucose, tags, date,
                                                      note) =>
                                                  'Glucose',
                                              weight: (id, weight, tags, date,
                                                      note) =>
                                                  'Weight',
                                              bloodPressure: (id,
                                                      systolic,
                                                      diastolic,
                                                      heartRate,
                                                      tags,
                                                      date,
                                                      note) =>
                                                  'Blood Pressure',
                                              insulin: (id, units, insulinName,
                                                      tags, date, note) =>
                                                  'Insulin',
                                              medication: (id,
                                                      medicationName,
                                                      medicationTime,
                                                      tags,
                                                      date,
                                                      note) =>
                                                  'Medications',
                                              carbs: (id,
                                                      carbohydrates,
                                                      food,
                                                      fat,
                                                      protein,
                                                      tags,
                                                      date,
                                                      note) =>
                                                  'Carbs',
                                              temperature: (id, temperature,
                                                      tags, date, note) =>
                                                  'Temperature',
                                              a1c:
                                                  (id, a1c, tags, date, note) =>
                                                      'A1C',
                                              exercise: (id,
                                                      exerciseType,
                                                      duration,
                                                      tags,
                                                      date,
                                                      note) =>
                                                  'Exercise',
                                              oxygen: (id, oxygen, heartRate,
                                                      tags, date, note) =>
                                                  'Oxygen',
                                              note: (id, tags, date, note) =>
                                                  'Notes',
                                              ketones: (id, ketones, tags, date,
                                                      note) =>
                                                  'Ketones',
                                            ))
                                        .where((type) => type.isNotEmpty)
                                        .toSet()
                                        .toList();
                                    recordTypes.sort();

                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: recordTypes.length,
                                      itemBuilder: (context, index) {
                                        final type = recordTypes[index];
                                        return CupertinoListTile(
                                          title: Text(type),
                                          trailing: _selectedType == type
                                              ? Icon(CupertinoIcons.check_mark,
                                                  color: primary1)
                                              : null,
                                          onTap: () {
                                            setState(() {
                                              _selectedType =
                                                  type == 'All Types'
                                                      ? null
                                                      : type;
                                            });
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                color: primary1,
                child: CupertinoSegmentedControl<int>(
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
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                )),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Consumer<HealthRecordProvider>(
                  builder: (context, provider, child) {
                    final spots = _getChartData(provider.records);

                    if (spots.isEmpty) {
                      return Center(
                        child: Text(
                          'No data available',
                          style: poppinsRegular.copyWith(
                            fontSize: 16,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      );
                    }

                    return FutureBuilder<double>(
                      future: _calculateA1C(provider.records),
                      builder: (context, snapshot) {
                        final a1c = snapshot.data ?? 0.0;
                        final List<FlSpot> a1cSpots = a1c > 0
                            ? [
                                FlSpot(0, a1c),
                                FlSpot(
                                    _getDaysForSegment(_selectedSegment)
                                        .toDouble(),
                                    a1c),
                              ]
                            : [];

                        return Column(
                          children: [
                            // Glucose Chart
                            Container(
                              height: MediaQuery.of(context).size.height * 0.4,
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: LineChart(
                                      LineChartData(
                                        minY: [
                                              (spots
                                                              .map((spot) =>
                                                                  spot.y)
                                                              .reduce((a, b) =>
                                                                  a < b
                                                                      ? a
                                                                      : b) /
                                                          10)
                                                      .floor() *
                                                  10,
                                              nonFastingMin.toDouble(),
                                            ].reduce((a, b) => a < b ? a : b) -
                                            10,
                                        maxY: [
                                              (spots
                                                              .map((spot) =>
                                                                  spot.y)
                                                              .reduce((a, b) =>
                                                                  a > b
                                                                      ? a
                                                                      : b) /
                                                          10)
                                                      .ceil() *
                                                  10,
                                              nonFastingMax.toDouble(),
                                            ].reduce((a, b) => a > b ? a : b) +
                                            10,
                                        gridData: FlGridData(
                                          show: true,
                                          horizontalInterval: 10,
                                          getDrawingHorizontalLine: (value) {
                                            if (_selectedType == 'Glucose' &&
                                                (value == nonFastingMin ||
                                                    value == nonFastingMax)) {
                                              return const FlLine(
                                                color:
                                                    CupertinoColors.systemRed,
                                                strokeWidth: 1,
                                                dashArray: [5, 5],
                                              );
                                            }
                                            return FlLine(
                                              color: CupertinoColors.systemGrey
                                                  .withOpacity(0.2),
                                              strokeWidth: 1,
                                            );
                                          },
                                        ),
                                        titlesData: FlTitlesData(
                                          leftTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              interval: 10,
                                              reservedSize: 24,
                                              getTitlesWidget: (value, meta) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0),
                                                  child: Text(
                                                    value.toInt().toString(),
                                                    style: poppinsRegular
                                                        .copyWith(fontSize: 11),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              reservedSize: 32,
                                              getTitlesWidget: (value, meta) {
                                                final date = DateTime.now()
                                                    .subtract(Duration(
                                                        days: _getDaysForSegment(
                                                                _selectedSegment) -
                                                            value.toInt()));
                                                return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 12),
                                                    child: Transform.rotate(
                                                      angle:
                                                          -45 * 3.14159 / 180,
                                                      child: Text(
                                                        '${date.month}/${date.day}',
                                                        style: poppinsRegular
                                                            .copyWith(
                                                                fontSize: 11),
                                                      ),
                                                    ));
                                              },
                                            ),
                                          ),
                                          rightTitles: const AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false),
                                          ),
                                          topTitles: const AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false),
                                          ),
                                        ),
                                        borderData: FlBorderData(
                                            show: true,
                                            border: Border.all(
                                                color: CupertinoColors
                                                    .systemGrey
                                                    .withOpacity(0.2))),
                                        lineBarsData: [
                                          // Glucose chart segments
                                          ...spots.asMap().entries.map((entry) {
                                            final currentSpot = entry.value;
                                            final nextSpot =
                                                entry.key < spots.length - 1
                                                    ? spots[entry.key + 1]
                                                    : null;

                                            if (nextSpot == null) {
                                              return LineChartBarData(
                                                spots: [currentSpot],
                                                isCurved: false,
                                                color: currentSpot.y <
                                                        nonFastingMin
                                                    ? primary1
                                                    : currentSpot.y >
                                                            nonFastingMax
                                                        ? CupertinoColors
                                                            .systemRed
                                                        : CupertinoColors
                                                            .systemGreen,
                                                dotData: const FlDotData(
                                                    show: false),
                                                belowBarData:
                                                    BarAreaData(show: false),
                                              );
                                            }

                                            final currentColor = currentSpot.y <
                                                    nonFastingMin
                                                ? primary1
                                                : currentSpot.y > nonFastingMax
                                                    ? CupertinoColors.systemRed
                                                    : CupertinoColors
                                                        .systemGreen;

                                            final nextColor = nextSpot.y <
                                                    nonFastingMin
                                                ? primary1
                                                : nextSpot.y > nonFastingMax
                                                    ? CupertinoColors.systemRed
                                                    : CupertinoColors
                                                        .systemGreen;

                                            return LineChartBarData(
                                              spots: [currentSpot, nextSpot],
                                              isCurved: false,
                                              color: currentColor == nextColor
                                                  ? currentColor
                                                  : CupertinoColors.systemGrey,
                                              dotData:
                                                  const FlDotData(show: false),
                                              belowBarData:
                                                  BarAreaData(show: false),
                                            );
                                          }),
                                          // Glucose points
                                          LineChartBarData(
                                            spots: spots,
                                            isCurved: false,
                                            color: Colors.transparent,
                                            dotData: FlDotData(
                                              show: true,
                                              getDotPainter: (spot, percent,
                                                  barData, index) {
                                                final color =
                                                    spot.y < nonFastingMin
                                                        ? primary1
                                                        : spot.y > nonFastingMax
                                                            ? CupertinoColors
                                                                .systemRed
                                                            : CupertinoColors
                                                                .systemGreen;
                                                return FlDotCirclePainter(
                                                  radius: 4,
                                                  color: color,
                                                  strokeWidth: 2,
                                                  strokeColor: white,
                                                );
                                              },
                                            ),
                                            belowBarData:
                                                BarAreaData(show: false),
                                          ),
                                          // Non-fasting min line
                                          LineChartBarData(
                                            spots: [
                                              FlSpot(
                                                  0, nonFastingMin.toDouble()),
                                              FlSpot(
                                                  _getDaysForSegment(
                                                          _selectedSegment)
                                                      .toDouble(),
                                                  nonFastingMin.toDouble()),
                                            ],
                                            isCurved: false,
                                            color: CupertinoColors.systemRed,
                                            dotData:
                                                const FlDotData(show: false),
                                            dashArray: [5, 5],
                                            belowBarData:
                                                BarAreaData(show: false),
                                          ),
                                          // Non-fasting max line
                                          LineChartBarData(
                                            spots: [
                                              FlSpot(
                                                  0, nonFastingMax.toDouble()),
                                              FlSpot(
                                                  _getDaysForSegment(
                                                          _selectedSegment)
                                                      .toDouble(),
                                                  nonFastingMax.toDouble()),
                                            ],
                                            isCurved: false,
                                            color: CupertinoColors.systemRed,
                                            dotData:
                                                const FlDotData(show: false),
                                            dashArray: [5, 5],
                                            belowBarData:
                                                BarAreaData(show: false),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _buildLegendItem(
                                            CupertinoColors.systemRed,
                                            'Above Target'),
                                        const SizedBox(width: 16),
                                        _buildLegendItem(
                                            CupertinoColors.systemGreen,
                                            'Normal'),
                                        const SizedBox(width: 16),
                                        _buildLegendItem(
                                            primary1, 'Below Target'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // A1C Chart
                            if (a1c > 0)
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: LineChart(
                                        LineChartData(
                                          minY: (a1c - 1.0).floorToDouble(),
                                          maxY: (a1c + 1.0).ceilToDouble(),
                                          gridData: FlGridData(
                                            show: true,
                                            horizontalInterval: 0.5,
                                            getDrawingHorizontalLine: (value) {
                                              return FlLine(
                                                color: CupertinoColors
                                                    .systemGrey
                                                    .withOpacity(0.2),
                                                strokeWidth: 1,
                                              );
                                            },
                                          ),
                                          titlesData: FlTitlesData(
                                            leftTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                interval: 0.5,
                                                reservedSize: 24,
                                                getTitlesWidget: (value, meta) {
                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 0),
                                                    child: Text(
                                                      value.toStringAsFixed(1),
                                                      style: poppinsRegular
                                                          .copyWith(
                                                              fontSize: 11),
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                reservedSize: 32,
                                                getTitlesWidget: (value, meta) {
                                                  final date = DateTime.now()
                                                      .subtract(Duration(
                                                          days: _getDaysForSegment(
                                                                  _selectedSegment) -
                                                              value.toInt()));
                                                  return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 12),
                                                      child: Transform.rotate(
                                                        angle:
                                                            -45 * 3.14159 / 180,
                                                        child: Text(
                                                          '${date.month}/${date.day}',
                                                          style: poppinsRegular
                                                              .copyWith(
                                                                  fontSize: 11),
                                                        ),
                                                      ));
                                                },
                                              ),
                                            ),
                                            rightTitles: const AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            topTitles: const AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                          ),
                                          borderData: FlBorderData(
                                              show: true,
                                              border: Border.all(
                                                  color: CupertinoColors
                                                      .systemGrey
                                                      .withOpacity(0.2))),
                                          lineBarsData: [
                                            LineChartBarData(
                                              spots: a1cSpots,
                                              isCurved: false,
                                              color: primary1,
                                              dotData:
                                                  const FlDotData(show: false),
                                              belowBarData:
                                                  BarAreaData(show: false),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          _buildLegendItem(
                                              primary1, 'Avg. A1C'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 2,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: poppinsRegular.copyWith(
            fontSize: 12,
            color: CupertinoColors.systemGrey,
          ),
        ),
      ],
    );
  }
}
