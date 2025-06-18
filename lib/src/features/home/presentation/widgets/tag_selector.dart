import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/core/providers/health_record_provider.dart';
import 'package:provider/provider.dart';

class TagSelector extends StatelessWidget {
  final String? selectedTag;
  final Function(String?) onTagSelected;

  const TagSelector({
    super.key,
    required this.selectedTag,
    required this.onTagSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      color: CupertinoColors.systemBackground,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: CupertinoColors.systemBackground,
              border: Border(
                bottom: BorderSide(
                  color: CupertinoColors.systemGrey.withOpacity(0.2),
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
                      trailing: selectedTag == tag
                          ? Icon(CupertinoIcons.check_mark, color: primary1)
                          : null,
                      onTap: () {
                        onTagSelected(tag == 'All Tags' ? null : tag);
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
    );
  }
}
