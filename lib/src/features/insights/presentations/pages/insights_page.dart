import 'package:auto_route/auto_route.dart' hide CupertinoPageRoute;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/core/entities/health_record.dart';
import 'package:flutter_app/src/core/providers/health_record_provider.dart';
import 'package:flutter_app/src/features/insights/presentations/pages/create_report_page.dart';
import 'package:provider/provider.dart';

@RoutePage()
class InsightsPage extends StatefulWidget {
  const InsightsPage({super.key});

  @override
  State<StatefulWidget> createState() => _InsightsPageState();
}

class _InsightsPageState extends State<InsightsPage> {
  // Helper method to calculate average glucose for a given time range
  double _calculateGlucoseAverage(
      List<HealthRecord> records, DateTime startDate) {
    final glucoseRecords = records.where((record) =>
        record.maybeMap(
          glucose: (value) => true,
          orElse: () => false,
        ) &&
        record.date != null &&
        record.date!.isAfter(startDate));

    if (glucoseRecords.isEmpty) return 0.0;

    final sum = glucoseRecords.fold<double>(
      0.0,
      (sum, record) =>
          sum +
          record.maybeMap(
            glucose: (value) => value.glucose,
            orElse: () => 0.0,
          ),
    );

    return sum / glucoseRecords.length;
  }

  // Helper method to calculate average blood pressure for a given time range
  Map<String, double> _calculateBloodPressureAverage(
      List<HealthRecord> records, DateTime startDate) {
    final bpRecords = records.where((record) =>
        record.maybeMap(
          bloodPressure: (value) => true,
          orElse: () => false,
        ) &&
        record.date != null &&
        record.date!.isAfter(startDate));

    if (bpRecords.isEmpty) {
      return {'systolic': 0.0, 'diastolic': 0.0};
    }

    var systolicSum = 0.0;
    var diastolicSum = 0.0;
    var count = 0;

    for (final record in bpRecords) {
      record.maybeMap(
        bloodPressure: (value) {
          systolicSum += value.systolic;
          diastolicSum += value.diastolic;
          count++;
        },
        orElse: () {},
      );
    }

    return {
      'systolic': systolicSum / count,
      'diastolic': diastolicSum / count,
    };
  }

  // Helper method to calculate average weight for a given time range
  double _calculateWeightAverage(
      List<HealthRecord> records, DateTime startDate) {
    final weightRecords = records.where((record) =>
        record.maybeMap(
          weight: (value) => true,
          orElse: () => false,
        ) &&
        record.date != null &&
        record.date!.isAfter(startDate));

    if (weightRecords.isEmpty) return 0.0;

    final sum = weightRecords.fold<double>(
      0.0,
      (sum, record) =>
          sum +
          record.maybeMap(
            weight: (value) => value.weight,
            orElse: () => 0.0,
          ),
    );

    return sum / weightRecords.length;
  }

  // Helper method to calculate AM/PM averages
  Map<String, double> _calculateDayPartAverages(
      List<HealthRecord> records, String type) {
    final amRecords = records.where((record) =>
        record.date != null &&
        record.date!.hour >= 0 &&
        record.date!.hour < 12 &&
        record.maybeMap(
          glucose: (value) => type == 'glucose',
          weight: (value) => type == 'weight',
          bloodPressure: (value) => type == 'bloodPressure',
          orElse: () => false,
        ));

    final pmRecords = records.where((record) =>
        record.date != null &&
        record.date!.hour >= 12 &&
        record.date!.hour < 24 &&
        record.maybeMap(
          glucose: (value) => type == 'glucose',
          weight: (value) => type == 'weight',
          bloodPressure: (value) => type == 'bloodPressure',
          orElse: () => false,
        ));

    if (type == 'bloodPressure') {
      final amBP = _calculateBloodPressureAverage(amRecords.toList(),
          DateTime(2000)); // Past date to include all records
      final pmBP = _calculateBloodPressureAverage(pmRecords.toList(),
          DateTime(2000)); // Past date to include all records
      return {
        'amSystolic': amBP['systolic'] ?? 0.0,
        'amDiastolic': amBP['diastolic'] ?? 0.0,
        'pmSystolic': pmBP['systolic'] ?? 0.0,
        'pmDiastolic': pmBP['diastolic'] ?? 0.0,
      };
    } else {
      double amAvg = 0.0;
      double pmAvg = 0.0;

      if (amRecords.isNotEmpty) {
        amAvg = amRecords.fold<double>(
              0.0,
              (sum, record) =>
                  sum +
                  record.maybeMap(
                    glucose: (value) => type == 'glucose' ? value.glucose : 0.0,
                    weight: (value) => type == 'weight' ? value.weight : 0.0,
                    orElse: () => 0.0,
                  ),
            ) /
            amRecords.length;
      }

      if (pmRecords.isNotEmpty) {
        pmAvg = pmRecords.fold<double>(
              0.0,
              (sum, record) =>
                  sum +
                  record.maybeMap(
                    glucose: (value) => type == 'glucose' ? value.glucose : 0.0,
                    weight: (value) => type == 'weight' ? value.weight : 0.0,
                    orElse: () => 0.0,
                  ),
            ) /
            pmRecords.length;
      }

      return {'am': amAvg, 'pm': pmAvg};
    }
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              title,
              style: poppinsMedium.copyWith(
                fontSize: 17,
                color: textColor,
              ),
            ),
          ),
        CupertinoListSection.insetGrouped(
          backgroundColor: CupertinoColors.systemGroupedBackground,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          children: children,
        ),
      ],
    );
  }

  Widget _buildInsightItem({
    required String title,
    String? value,
    bool showArrow = false,
    VoidCallback? onTap,
  }) {
    return CupertinoListTile(
      title: Text(
        title,
        style: poppinsRegular.copyWith(fontSize: 16),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value != null)
            Text(
              value,
              style: poppinsRegular.copyWith(
                fontSize: 16,
                color: CupertinoColors.systemGrey,
              ),
            ),
          if (showArrow) ...[
            if (value != null) const SizedBox(width: 4),
            const Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.systemGrey,
              size: 16,
            ),
          ],
        ],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HealthRecordProvider>(
      builder: (context, provider, child) {
        final records = provider.records;
        final now = DateTime.now();

        // Calculate time ranges
        final sevenDaysAgo = now.subtract(const Duration(days: 7));
        final thirtyDaysAgo = now.subtract(const Duration(days: 30));
        final sixtyDaysAgo = now.subtract(const Duration(days: 60));
        final ninetyDaysAgo = now.subtract(const Duration(days: 90));

        // Calculate glucose averages
        final glucose7Day = _calculateGlucoseAverage(records, sevenDaysAgo);
        final glucose30Day = _calculateGlucoseAverage(records, thirtyDaysAgo);
        final glucose60Day = _calculateGlucoseAverage(records, sixtyDaysAgo);
        final glucose90Day = _calculateGlucoseAverage(records, ninetyDaysAgo);
        final glucoseDayPart = _calculateDayPartAverages(records, 'glucose');

        // Calculate blood pressure averages
        final bp7Day = _calculateBloodPressureAverage(records, sevenDaysAgo);
        final bp30Day = _calculateBloodPressureAverage(records, thirtyDaysAgo);
        final bp60Day = _calculateBloodPressureAverage(records, sixtyDaysAgo);
        final bp90Day = _calculateBloodPressureAverage(records, ninetyDaysAgo);
        final bpDayPart = _calculateDayPartAverages(records, 'bloodPressure');

        // Calculate weight averages
        final weight7Day = _calculateWeightAverage(records, sevenDaysAgo);
        final weight30Day = _calculateWeightAverage(records, thirtyDaysAgo);
        final weight60Day = _calculateWeightAverage(records, sixtyDaysAgo);
        final weight90Day = _calculateWeightAverage(records, ninetyDaysAgo);
        final weightDayPart = _calculateDayPartAverages(records, 'weight');

        return CupertinoPageScaffold(
          // backgroundColor: CupertinoColors.systemGroupedBackground,
          backgroundColor: primary1,
          navigationBar: CupertinoNavigationBar(
            backgroundColor: primary1,
            border: Border(
              bottom: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
            middle: Text(
              'Insights',
              style: poppinsMedium.copyWith(color: white, fontSize: 18),
            ),
            leading: CupertinoButton(
              padding: const EdgeInsets.all(4),
              child: Icon(
                CupertinoIcons.profile_circled,
                size: 24,
                color: white,
              ),
              onPressed: () {
                // Navigate to settings
              },
            ),
          ),
          child: Container(
            color: CupertinoColors.systemGroupedBackground,
            child: SafeArea(
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  // Section 1: Reports
                  _buildSection(
                    '',
                    [
                      _buildInsightItem(
                        title: 'Create Report',
                        showArrow: true,
                        onTap: () {
                          // Navigate to create report
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const CreateReportPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Section 2: Estimated A1C
                  _buildSection(
                    '',
                    [
                      _buildInsightItem(
                        title: 'Estimated A1C',
                        value:
                            'est. A1C: ${(glucose90Day * 0.0296 + 2.419).toStringAsFixed(2)}%',
                      ),
                    ],
                  ),

                  // Section 3: Glucose
                  _buildSection(
                    'Glucose',
                    [
                      _buildInsightItem(
                        title: '7 Day Average',
                        value: '${glucose7Day.toStringAsFixed(1)} mg/dL',
                      ),
                      _buildInsightItem(
                        title: '30 Day Average',
                        value: '${glucose30Day.toStringAsFixed(1)} mg/dL',
                      ),
                      _buildInsightItem(
                        title: '60 Day Average',
                        value: '${glucose60Day.toStringAsFixed(1)} mg/dL',
                      ),
                      _buildInsightItem(
                        title: '90 Day Average',
                        value: '${glucose90Day.toStringAsFixed(1)} mg/dL',
                      ),
                      _buildInsightItem(
                        title: 'AM Average',
                        value:
                            '${glucoseDayPart['am']?.toStringAsFixed(1)} mg/dL',
                      ),
                      _buildInsightItem(
                        title: 'PM Average',
                        value:
                            '${glucoseDayPart['pm']?.toStringAsFixed(1)} mg/dL',
                      ),
                      _buildInsightItem(
                        title: 'Average By Weekday',
                        showArrow: true,
                        onTap: () {
                          // Navigate to weekday averages
                        },
                      ),
                      _buildInsightItem(
                        title: 'Average By Month',
                        showArrow: true,
                        onTap: () {
                          // Navigate to monthly averages
                        },
                      ),
                    ],
                  ),

                  // Section 4: Blood Pressure
                  _buildSection(
                    'Blood Pressure',
                    [
                      _buildInsightItem(
                        title: '7 Day Average',
                        value:
                            '${bp7Day['systolic']?.toStringAsFixed(0)}/${bp7Day['diastolic']?.toStringAsFixed(0)}',
                      ),
                      _buildInsightItem(
                        title: '30 Day Average',
                        value:
                            '${bp30Day['systolic']?.toStringAsFixed(0)}/${bp30Day['diastolic']?.toStringAsFixed(0)}',
                      ),
                      _buildInsightItem(
                        title: '60 Day Average',
                        value:
                            '${bp60Day['systolic']?.toStringAsFixed(0)}/${bp60Day['diastolic']?.toStringAsFixed(0)}',
                      ),
                      _buildInsightItem(
                        title: '90 Day Average',
                        value:
                            '${bp90Day['systolic']?.toStringAsFixed(0)}/${bp90Day['diastolic']?.toStringAsFixed(0)}',
                      ),
                      _buildInsightItem(
                        title: 'AM Average',
                        value:
                            '${bpDayPart['amSystolic']?.toStringAsFixed(0)}/${bpDayPart['amDiastolic']?.toStringAsFixed(0)}',
                      ),
                      _buildInsightItem(
                        title: 'PM Average',
                        value:
                            '${bpDayPart['pmSystolic']?.toStringAsFixed(0)}/${bpDayPart['pmDiastolic']?.toStringAsFixed(0)}',
                      ),
                      _buildInsightItem(
                        title: 'Average By Weekday',
                        showArrow: true,
                        onTap: () {
                          // Navigate to weekday averages
                        },
                      ),
                      _buildInsightItem(
                        title: 'Average By Month',
                        showArrow: true,
                        onTap: () {
                          // Navigate to monthly averages
                        },
                      ),
                    ],
                  ),

                  // Section 5: Weight
                  _buildSection(
                    'Weight',
                    [
                      _buildInsightItem(
                        title: '7 Day Average',
                        value: '${weight7Day.toStringAsFixed(1)} kg',
                      ),
                      _buildInsightItem(
                        title: '30 Day Average',
                        value: '${weight30Day.toStringAsFixed(1)} kg',
                      ),
                      _buildInsightItem(
                        title: '60 Day Average',
                        value: '${weight60Day.toStringAsFixed(1)} kg',
                      ),
                      _buildInsightItem(
                        title: '90 Day Average',
                        value: '${weight90Day.toStringAsFixed(1)} kg',
                      ),
                      _buildInsightItem(
                        title: 'AM Average',
                        value: '${weightDayPart['am']?.toStringAsFixed(1)} kg',
                      ),
                      _buildInsightItem(
                        title: 'PM Average',
                        value: '${weightDayPart['pm']?.toStringAsFixed(1)} kg',
                      ),
                      _buildInsightItem(
                        title: 'Average By Weekday',
                        showArrow: true,
                        onTap: () {
                          // Navigate to weekday averages
                        },
                      ),
                      _buildInsightItem(
                        title: 'Average By Month',
                        showArrow: true,
                        onTap: () {
                          // Navigate to monthly averages
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
