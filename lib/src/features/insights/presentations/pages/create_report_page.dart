import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/features/insights/presentations/pages/csv_generator.dart';
import 'package:flutter_app/src/features/insights/presentations/pages/pdf_generator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CreateReportPage extends StatefulWidget {
  const CreateReportPage({super.key});

  @override
  State<CreateReportPage> createState() => _CreateReportPageState();
}

class _CreateReportPageState extends State<CreateReportPage> {
  int _selectedFileType = 0; // 0 for PDF, 1 for CSV
  int _selectedDays = 3; // Default to Last 90 days
  DateTime _fromDate = DateTime.now().subtract(const Duration(days: 90));
  DateTime _untilDate = DateTime.now();
  bool _includeAverages = true;
  bool _includeNameDOB = true;
  String _name = '';
  DateTime _dob = DateTime(1990);
  int _selectedSort = 0; // 0 for Date, 1 for Log Type
  Set<String> _selectedLogTypes = {};

  final List<String> _daysOptions = [
    'Last 7 days',
    'Last 14 days',
    'Last 30 days',
    'Last 90 days',
    'Last 180 days',
    'Last 365 days',
  ];

  final List<String> _logTypes = [
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

  @override
  void initState() {
    // TODO: implement initState
    _selectedLogTypes = Set.from(_logTypes);
    super.initState();
  }

  DateTime? getDate(String key) {
    switch (key) {
      case 'from':
        return _fromDate;
      case 'until':
        return _untilDate;
      case 'dob':
        return _dob;
      default:
        return null;
    }
  }

  void _showDatePicker(BuildContext context, String key) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: CupertinoDatePicker(
            initialDateTime: getDate(key),
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                switch (key) {
                  case 'from':
                    _fromDate = newDate;
                    break;
                  case 'until':
                    _untilDate = newDate;
                    break;
                  case 'dob':
                    _dob = newDate;
                    break;
                }
              });
            },
          ),
        ),
      ),
    );
  }

  void _showDaysPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: _daysOptions.asMap().entries.map((entry) {
          return CupertinoActionSheetAction(
            onPressed: () {
              setState(() {
                _selectedDays = entry.key;
                _fromDate = DateTime.now().subtract(
                    Duration(days: [7, 14, 30, 90, 180, 365][entry.key]));
              });
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  entry.value,
                  style: poppinsRegular.copyWith(fontSize: 16),
                ),
                if (entry.key == _selectedDays)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      CupertinoIcons.check_mark,
                      color: primary1,
                      size: 18,
                    ),
                  ),
              ],
            ),
          );
        }).toList(),
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: poppinsRegular.copyWith(
              fontSize: 16,
              color: CupertinoColors.destructiveRed,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: CupertinoListSection.insetGrouped(
        header: Text(
          title,
          style: poppinsRegular.copyWith(
            fontSize: 14,
            color: CupertinoColors.systemGrey,
          ),
        ),
        children: children,
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return CupertinoListTile(
      title: Text(
        title,
        style: poppinsRegular.copyWith(fontSize: 16),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primary1,
        middle: Text(
          'Create Report',
          style: poppinsMedium.copyWith(color: white, fontSize: 18),
        ),
        leading: CupertinoButton(
          padding: const EdgeInsets.all(4),
          child: Icon(
            CupertinoIcons.back,
            size: 24,
            color: white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        trailing: CupertinoButton(
          padding: const EdgeInsets.all(4),
          child: Text(
            'Next',
            style: poppinsRegular.copyWith(color: white),
          ),
          onPressed: () async {
            // TODO: Implement next functionality
            if (_selectedFileType == 0) {
              final pdf = await PDFGenerator.generatePDFWithDetails(
                context: context,
                fromDate: _fromDate,
                untilDate: _untilDate,
                selectedLogTypes: _selectedLogTypes,
                includeAverages: _includeAverages,
                includeNameDOB: _includeNameDOB,
                name: _name,
                dob: _dob,
                sortType: _selectedSort,
              );
              await Share.shareXFiles(
                [XFile(pdf.path)],
                subject: 'Health Report PDF',
                text: 'Here is your health report in PDF format.',
              );
            } else {
              final csv = await CSVGenerator.generateCSV(
                context: context,
                startDate: _fromDate,
                endDate: _untilDate,
                selectedLogTypes: _selectedLogTypes.toList(),
              );
              await Share.shareXFiles(
                [XFile(csv.path)],
                subject: 'Health Report CSV',
                text: 'Here is your health report in CSV format.',
              );
            }
          },
        ),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            // Section 1: FILE TYPE
            _buildSection(
              'FILE TYPE',
              [
                Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: grey4,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: CupertinoSegmentedControl<int>(
                        children: {
                          0: Container(
                              child: Text(
                            'PDF',
                            style: poppinsRegular.copyWith(
                              fontSize: 14,
                              color: textColor,
                            ),
                          )),
                          1: Container(
                              child: Text(
                            'CSV',
                            style: poppinsRegular.copyWith(
                              fontSize: 14,
                              color: textColor,
                            ),
                          )),
                        },
                        onValueChanged: (int value) {
                          setState(() {
                            _selectedFileType = value;
                          });
                        },
                        groupValue: _selectedFileType,
                        unselectedColor: grey4,
                        selectedColor: white,
                        borderColor: CupertinoColors.transparent,
                      ),
                    )),
              ],
            ),

            // Section 2: DATE RANGE
            _buildSection(
              'DATE RANGE',
              [
                _buildSettingItem(
                  title: 'How many days of data?',
                  trailing: Text(
                    _daysOptions[_selectedDays],
                    style: poppinsRegular.copyWith(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  onTap: () => _showDaysPicker(context),
                ),
                _buildSettingItem(
                  title: 'From',
                  trailing: Text(
                    '${_fromDate.day} ${_getMonthName(_fromDate.month)} ${_fromDate.year}',
                    style: poppinsRegular.copyWith(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  onTap: () => _showDatePicker(context, 'from'),
                ),
                _buildSettingItem(
                  title: 'Until',
                  trailing: Text(
                    '${_untilDate.day} ${_getMonthName(_untilDate.month)} ${_untilDate.year}',
                    style: poppinsRegular.copyWith(
                      fontSize: 16,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                  onTap: () => _showDatePicker(context, 'until'),
                ),
              ],
            ),

            // Section 3: PDF Options (only shown for PDF)

            _buildSection(
              '',
              [
                if (_selectedFileType == 0)
                  _buildSettingItem(
                    title: 'Include Averages',
                    trailing: CupertinoSwitch(
                      value: _includeAverages,
                      onChanged: (value) {
                        setState(() {
                          _includeAverages = value;
                        });
                      },
                      activeTrackColor: primary1,
                    ),
                  ),
                if (_selectedFileType == 0)
                  _buildSettingItem(
                    title: 'Include Name & DOB',
                    trailing: CupertinoSwitch(
                      value: _includeNameDOB,
                      onChanged: (value) {
                        setState(() {
                          _includeNameDOB = value;
                        });
                      },
                      activeTrackColor: primary1,
                    ),
                  ),
                if (_includeNameDOB) ...[
                  _buildSettingItem(
                    title: 'Name',
                    trailing: SizedBox(
                      width: 150,
                      child: CupertinoTextField(
                        placeholder: 'Enter name',
                        textAlign: TextAlign.right,
                        style: poppinsRegular.copyWith(fontSize: 16),
                        onChanged: (value) {
                          setState(() {
                            _name = value;
                          });
                        },
                      ),
                    ),
                  ),
                  _buildSettingItem(
                    title: 'Date of Birth',
                    trailing: Text(
                      '${_dob.day} ${_getMonthName(_dob.month)} ${_dob.year}',
                      style: poppinsRegular.copyWith(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                    onTap: () => _showDatePicker(context, 'dob'),
                  ),
                ],
              ],
            ),

            // Section 4: SORT
            _buildSection(
              'SORT',
              [
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: white,
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: grey4,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: CupertinoSegmentedControl<int>(
                      children: {
                        0: Text(
                          'Date',
                          style: poppinsRegular.copyWith(
                            fontSize: 14,
                            color: textColor,
                          ),
                        ),
                        1: Text(
                          'Log Type',
                          style: poppinsRegular.copyWith(
                            fontSize: 14,
                            color: textColor,
                          ),
                        ),
                      },
                      onValueChanged: (int value) {
                        setState(() {
                          _selectedSort = value;
                        });
                      },
                      groupValue: _selectedSort,
                      unselectedColor: grey4,
                      selectedColor: white,
                      borderColor: CupertinoColors.transparent,
                    ),
                  ),
                ),
              ],
            ),

            // Section 5: LOG TYPES
            _buildSection(
              'LOG TYPES',
              _logTypes.map((type) {
                return _buildSettingItem(
                  title: type,
                  trailing: _selectedLogTypes.contains(type)
                      ? Icon(
                          CupertinoIcons.check_mark,
                          color: primary1,
                        )
                      : null,
                  onTap: () {
                    setState(() {
                      if (_selectedLogTypes.contains(type)) {
                        _selectedLogTypes.remove(type);
                      } else {
                        _selectedLogTypes.add(type);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return monthNames[month - 1];
  }
}
