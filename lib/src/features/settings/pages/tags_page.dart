import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/core/providers/health_record_provider.dart';
import 'package:provider/provider.dart';

class TagsPage extends StatefulWidget {
  bool isModal = false;

  TagsPage({super.key, this.isModal = false});

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  final List<String> _selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primary1,
        middle: Text(
          'Tags',
          style: poppinsRegular.copyWith(
            fontSize: 18,
            color: white,
          ),
        ),
        leading: CupertinoButton(
          padding: const EdgeInsets.all(4),
          child: Icon(CupertinoIcons.xmark, color: white, size: 24),
          onPressed: () {
            if (widget.isModal) {
              Navigator.pop(context);
            }
          },
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.add_circled,
            color: white,
            size: 24,
          ),
          onPressed: () => _showCreateTagModal(context),
        ),
      ),
      child: SafeArea(
        child: Consumer<HealthRecordProvider>(
          builder: (context, provider, child) {
            return FutureBuilder<List<String>>(
              future: provider.getAllTags(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading tags: ${snapshot.error}',
                      style: poppinsRegular.copyWith(
                        color: CupertinoColors.destructiveRed,
                      ),
                    ),
                  );
                }
                final allTags = snapshot.data ?? [];
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: allTags.length,
                  itemBuilder: (context, index) {
                    final tag = allTags[index];
                    return Dismissible(
                      key: Key(tag),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: CupertinoColors.destructiveRed,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 16),
                        child: const Icon(
                          CupertinoIcons.delete,
                          color: CupertinoColors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        context.read<HealthRecordProvider>().deleteTag(tag);
                      },
                      child: CupertinoListTile(
                        title: Text(tag),
                        trailing: _selectedTags.contains(tag)
                            ? Icon(
                                CupertinoIcons.check_mark,
                                color: primary1,
                              )
                            : null,
                        onTap: () {
                          setState(() {
                            if (_selectedTags.contains(tag)) {
                              _selectedTags.remove(tag);
                            } else {
                              _selectedTags.add(tag);
                            }
                          });
                        },
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showCreateTagModal(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Create New Tag'),
        content: CupertinoTextField(
          controller: controller,
          placeholder: 'Enter tag name',
          autofocus: true,
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          CupertinoDialogAction(
            child: const Text('Create'),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<HealthRecordProvider>().addTag(controller.text);
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
