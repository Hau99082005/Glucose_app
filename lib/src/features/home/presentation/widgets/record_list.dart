import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/entities/health_record.dart';
import '../../../../core/providers/health_record_provider.dart';
import '../../../../core/utils/values/colors.dart';

class RecordList extends StatefulWidget {
  final String filter;
  final int daysToShow;
  final String? tagFilter;

  const RecordList({
    super.key,
    required this.filter,
    this.daysToShow = 3,
    this.tagFilter,
  });

  @override
  State<RecordList> createState() => _RecordListState();
}

class _RecordListState extends State<RecordList> {
  Set<String> _selectedTypes = {};
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _loadSelectedTypes();
  }

  void _loadSelectedTypes() {
    final selected = _prefs.getStringList('selected_log_types') ??
        [
          'Glucose',
          'Weight',
          'Blood Pressure',
          'Insulin',
          'Medication',
          'Carbs',
          'Temperature',
          'A1C',
          'Exercise',
          'Oxygen',
          'Note',
          'Ketones',
        ];
    if (mounted) {
      setState(() {
        _selectedTypes = Set<String>.from(selected);
      });
    }
  }

  bool _isRecordTypeVisible(HealthRecord record) {
    final recordType = record.runtimeType.toString().replaceAll('Record', '');
    return _selectedTypes.contains(recordType) || recordType == 'Glucose';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthRecordProvider>(
      builder: (context, provider, child) {
        final DateTime cutoffDate =
            DateTime.now().subtract(Duration(days: widget.daysToShow));

        final records = provider.records.where((record) {
          // Apply date filter
          if (record.date?.isBefore(cutoffDate) ?? true) {
            return false;
          }

          // Apply tag filter if specified
          if (widget.tagFilter != null &&
              !record.tags.contains(widget.tagFilter)) {
            return false;
          }

          // Apply type filter
          if (widget.filter == 'All') {
            return _isRecordTypeVisible(record);
          }
          return record.runtimeType.toString().replaceAll('Record', '') ==
              widget.filter;
        }).toList();

        if (records.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  CupertinoIcons.doc_text_search,
                  size: 48,
                  color: CupertinoColors.systemGrey,
                ),
                SizedBox(height: 16),
                Text(
                  'No records found',
                  style: TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: records.length,
          itemBuilder: (context, index) {
            final record = records[index];
            return _buildRecordTile(record);
          },
        );
      },
    );
  }

  Widget _buildRecordTile(HealthRecord record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: redCF3A3A,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.systemGrey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CupertinoListTile(
        title: _buildTitle(record),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              record.date?.toString().split(' ')[0] ?? 'No date',
              style: const TextStyle(color: CupertinoColors.systemGrey),
            ),
            if (record.note?.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  record.note ?? '',
                  style: const TextStyle(color: CupertinoColors.systemGrey),
                ),
              ),
            if (record.tags.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Wrap(
                  spacing: 8,
                  children: record.tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: primary6,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: primary1,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
        trailing: const Icon(CupertinoIcons.chevron_right,
            color: CupertinoColors.systemGrey),
      ),
    );
  }

  Widget _buildTitle(HealthRecord record) {
    const titleStyle = TextStyle(
      color: CupertinoColors.label,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    );

    return record.maybeWhen(
      glucose: (id, glucose, tags, date, note) =>
          Text('Glucose: $glucose mg/dL', style: titleStyle),
      weight: (id, weight, tags, date, note) =>
          Text('Weight: $weight kg', style: titleStyle),
      bloodPressure: (id, systolic, diastolic, heartRate, tags, date, note) =>
          Text('BP: $systolic/$diastolic mmHg (HR: $heartRate)',
              style: titleStyle),
      insulin: (id, units, insulinName, tags, date, note) =>
          Text('Insulin: $units units - $insulinName', style: titleStyle),
      medication: (id, medicationName, medicationTime, tags, date, note) =>
          Text('Medication: $medicationName', style: titleStyle),
      carbs: (id, carbohydrates, food, fat, protein, tags, date, note) => Text(
          'Carbs: ${carbohydrates}g, Fat: ${fat}g, Protein: ${protein}g',
          style: titleStyle),
      temperature: (id, temperature, tags, date, note) =>
          Text('Temperature: $temperature°C', style: titleStyle),
      a1c: (id, a1c, tags, date, note) => Text('A1C: $a1c%', style: titleStyle),
      exercise: (id, exerciseType, duration, tags, date, note) => Text(
          'Exercise: $exerciseType (${duration.inMinutes} min)',
          style: titleStyle),
      oxygen: (id, oxygen, heartRate, tags, date, note) =>
          Text('O2: $oxygen% (HR: $heartRate)', style: titleStyle),
      note: (id, tags, date, note) => Text('Note', style: titleStyle),
      ketones: (id, ketones, tags, date, note) =>
          Text('Ketones: $ketones', style: titleStyle),
      orElse: () => Text('Unknown Record', style: titleStyle),
    );
  }
}
