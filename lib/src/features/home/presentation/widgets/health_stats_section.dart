import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/features/home/presentation/constants/history_page_constants.dart';

class HealthStatsSection extends StatelessWidget {
  final Map<String, String> stats;

  const HealthStatsSection({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoListSection.insetGrouped(
      backgroundColor: primary1,
      margin: EdgeInsets.zero,
      children: [
        CupertinoListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatItem('Avg', stats['avg']!),
              _buildStatItem('Prior Avg', stats['priorAvg']!),
              _buildStatItem('Low', stats['low']!),
              _buildStatItem('High', stats['high']!),
            ],
          ),
          backgroundColor: primary1,
          padding: const EdgeInsets.symmetric(horizontal: 48),
        ),
      ],
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: HistoryPageConstants.statItemFontSize,
            fontWeight: FontWeight.bold,
            color: grey6,
          ),
        ),
        const SizedBox(height: HistoryPageConstants.statItemSpacing),
        Text(
          value,
          style: TextStyle(
            fontSize: HistoryPageConstants.statItemFontSize,
            fontWeight: FontWeight.bold,
            color: white,
          ),
        ),
      ],
    );
  }
}
