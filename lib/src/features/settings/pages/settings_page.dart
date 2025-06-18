import 'package:auto_route/auto_route.dart' hide CupertinoPageRoute;
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/services/auth_service.dart';
import 'package:flutter_app/src/core/services/preferences_service.dart';
import 'package:flutter_app/src/core/utils/constants/app_constants.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/features/home/presentation/pages/reminders_page.dart';
import 'package:flutter_app/src/features/insights/presentations/pages/create_report_page.dart';
import 'package:flutter_app/src/features/medications/presentations/pages/medications_page.dart';
import 'package:flutter_app/src/features/settings/pages/profile_modal.dart';
import 'package:flutter_app/src/features/settings/pages/tags_page.dart';
import 'package:flutter_app/src/features/settings/pages/health_settings_page.dart';
import 'package:flutter_app/src/features/settings/pages/log_types_page.dart';
import 'package:provider/provider.dart';

// Add Material import
import 'package:flutter/material.dart'
    show Material, MaterialType, RangeSlider, RangeValues;

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
///
@RoutePage()
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const routeName = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late PreferencesService _prefs;
  late double _nonFastingMin;
  late double _nonFastingMax;
  late double _fastingMin;
  late double _fastingMax;
  late String _glucoseUnit;
  late String _weightUnit;
  bool _hideNotePreview = false;
  bool _hideQuickAddButton = false;
  bool _isBiometricEnabled = false;
  bool _isBiometricAvailable = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _prefs = Provider.of<PreferencesService>(context, listen: false);
    _loadPreferences();
    _checkBiometricSettings();
  }

  Future<void> _loadPreferences() async {
    setState(() {
      _nonFastingMin = _prefs.nonFastingMin;
      _nonFastingMax = _prefs.nonFastingMax;
      _fastingMin = _prefs.fastingMin;
      _fastingMax = _prefs.fastingMax;
      _glucoseUnit = _prefs.glucoseUnit;
      _weightUnit = _prefs.weightUnit;
      _hideNotePreview = _prefs.hideNotePreview;
      _hideQuickAddButton = _prefs.hideQuickAddButton;
    });
  }

  Future<void> _checkBiometricSettings() async {
    setState(() => _isLoading = true);
    try {
      final authService = Provider.of<AuthService>(context, listen: false);
      final canUseBiometrics = await authService.canUseBiometrics();
      final isEnabled = authService.isBiometricEnabled;

      if (mounted) {
        setState(() {
          _isBiometricAvailable = canUseBiometrics;
          _isBiometricEnabled = isEnabled;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isBiometricAvailable = false;
          _isBiometricEnabled = false;
          _isLoading = false;
        });
        _showErrorDialog('Error checking biometric availability');
      }
    }
  }

  Future<void> _handleBiometricToggle(bool value) async {
    try {
      final authService = Provider.of<AuthService>(context, listen: false);

      if (value) {
        // When turning on biometric auth, require authentication first
        final authenticated = await authService.authenticate();
        if (authenticated) {
          if (mounted) {
            setState(() => _isBiometricEnabled = true);
          }
          await authService.setBiometricEnabled(true);
        } else {
          // If authentication fails, keep the toggle off
          if (mounted) {
            setState(() => _isBiometricEnabled = false);
          }
          _showErrorDialog('Authentication failed. Please try again.');
        }
      } else {
        // Show confirmation dialog when disabling biometric auth
        final confirmed = await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Disable Biometric Authentication'),
            content: const Text(
                'Are you sure you want to disable biometric authentication?'),
            actions: [
              CupertinoDialogAction(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context, false),
              ),
              CupertinoDialogAction(
                onPressed: () => Navigator.pop(context, true),
                isDestructiveAction: true,
                child: const Text('Disable'),
              ),
            ],
          ),
        );

        if (confirmed == true) {
          if (mounted) {
            setState(() => _isBiometricEnabled = false);
          }
          await authService.setBiometricEnabled(false);
        }
      }
    } catch (e) {
      // If any error occurs, ensure the toggle state is correct
      if (mounted) {
        setState(() => _isBiometricEnabled = false);
      }
      _showErrorDialog('Error toggling biometric authentication');
    }
  }

  void _showErrorDialog(String message) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: grey6,
      child: SafeArea(
        child: ListView(
          children: [
            // Section 1: Profile and Medication
            _buildSection(
              [
                _buildSettingItem(
                  icon: CupertinoIcons.person_circle,
                  title: 'My Profile',
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => const ProfileModal(),
                    );
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.capsule,
                  title: 'My Medication',
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => MedicationsPage(isModal: true),
                    );
                  },
                ),
              ],
            ),

            // Section 2: Reports and Health
            _buildSection(
              [
                _buildSettingItem(
                  icon: CupertinoIcons.doc_text,
                  title: 'Report for a doctor',
                  onTap: () {
                    // Navigate to doctor report page
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const CreateReportPage(),
                      ),
                    );
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.heart,
                  title: 'Apple Health Settings',
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) =>
                          const HealthSettingsPage(isModal: true),
                    );
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.tag,
                  title: 'Tags',
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => TagsPage(isModal: true),
                    );
                  },
                ),
              ],
            ),

            // Section 3: Bluetooth
            _buildSection(
              [
                _buildSettingItem(
                  icon: CupertinoIcons.bluetooth,
                  title: 'Connect Bluetooth Meter',
                  onTap: () {
                    // Navigate to Bluetooth connection page
                  },
                ),
              ],
            ),

            // Section 4: Security
            _buildSection(
              [
                _buildSettingItem(
                  icon: CupertinoIcons.lock_shield,
                  title: 'Biometric Authentication',
                  subtitle: _isLoading
                      ? 'Checking availability...'
                      : _isBiometricAvailable
                          ? 'Use Face ID or Touch ID to secure your app'
                          : 'Biometric authentication is not available on this device',
                  isToggle: true,
                  toggleValue: _isBiometricEnabled,
                  onToggleChanged: _isBiometricAvailable && !_isLoading
                      ? _handleBiometricToggle
                      : null,
                ),
              ],
            ),

            // Section 5: Support and Feedback
            _buildSection(
              [
                _buildSettingItem(
                  icon: CupertinoIcons.mail,
                  title: 'Email Support',
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Email not available'),
                        content:
                            const Text('Please contact us at $supportEmail'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.question_circle,
                  title: 'Help & Feedback',
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Feature not available'),
                        content:
                            const Text('Please contact us at $supportEmail'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.lightbulb,
                  title: 'Suggest a feature',
                  onTap: () {
                    // Navigate to feature suggestion page
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Feature not available'),
                        content:
                            const Text('Please contact us at $supportEmail'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.list_bullet,
                  title: 'Feature Request List',
                  onTap: () {
                    // Navigate to feature request list
                    showCupertinoDialog(
                      context: context,
                      builder: (context) => CupertinoAlertDialog(
                        title: const Text('Feature not available'),
                        content:
                            const Text('Please contact us at $supportEmail'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('OK'),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),

            // Section 6: Reminders
            _buildSection(
              [
                _buildSettingItem(
                  icon: CupertinoIcons.bell,
                  title: 'My Reminders',
                  onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => const RemindersPage(),
                    );
                  },
                ),
              ],
            ),

            // Section 7: Preferences
            _buildSection(
              [
                _buildRangeSliderItem(
                  title: 'Non-fasting blood glucose target range',
                  minValue: _nonFastingMin,
                  maxValue: _nonFastingMax,
                  onMinChanged: (value) async {
                    setState(() => _nonFastingMin = value);
                    await _prefs.setNonFastingRange(value, _nonFastingMax);
                  },
                  onMaxChanged: (value) async {
                    setState(() => _nonFastingMax = value);
                    await _prefs.setNonFastingRange(_nonFastingMin, value);
                  },
                ),
                _buildRangeSliderItem(
                  title: 'Fasting target range',
                  minValue: _fastingMin,
                  maxValue: _fastingMax,
                  onMinChanged: (value) async {
                    setState(() => _fastingMin = value);
                    await _prefs.setFastingRange(value, _fastingMax);
                  },
                  onMaxChanged: (value) async {
                    setState(() => _fastingMax = value);
                    await _prefs.setFastingRange(_fastingMin, value);
                  },
                ),
                _buildActionSheetItem(
                  title: 'Change glucose unit',
                  selectedValue: _glucoseUnit,
                  options: ['mg/dL', 'mmol/L'],
                  onChanged: (value) async {
                    setState(() => _glucoseUnit = value);
                    await _prefs.setGlucoseUnit(value);
                  },
                ),
                _buildActionSheetItem(
                  title: 'Change weight unit',
                  selectedValue: _weightUnit,
                  options: ['lbs', 'kgs'],
                  onChanged: (value) async {
                    setState(() => _weightUnit = value);
                    await _prefs.setWeightUnit(value);
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.list_bullet,
                  title: 'Show/Hide Log Types',
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const LogTypesPage(),
                      ),
                    );
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.doc_text,
                  title: 'Hide note preview',
                  isToggle: true,
                  toggleValue: _hideNotePreview,
                  onToggleChanged: (value) {
                    setState(() {
                      _hideNotePreview = value;
                    });
                  },
                ),
                _buildSettingItem(
                  icon: CupertinoIcons.plus_circle,
                  title: 'Hide quick add button',
                  isToggle: true,
                  toggleValue: _hideQuickAddButton,
                  onToggleChanged: (value) async {
                    setState(() {
                      _hideQuickAddButton = value;
                    });
                    await _prefs.setHideQuickAddButton(value);
                  },
                ),
              ],
            ),

            _buildSection([
              _buildSettingItem(
                icon: CupertinoIcons.trash,
                title: 'Delete all data',
                isDestructive: true,
                onTap: () {
                  // show confirmation dialog
                  showCupertinoDialog(
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text('Delete all data'),
                      content: const Text(
                          'Are you sure you want to delete all data?'),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          child: const Text('Delete'),
                          onPressed: () {
                            // delete all data
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ])
          ],
        ),
      ),
    );
  }

  Widget _buildSection(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: CupertinoListSection.insetGrouped(
        children: children,
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    bool isToggle = false,
    bool toggleValue = false,
    ValueChanged<bool>? onToggleChanged,
    bool isDestructive = false,
    String? subtitle,
  }) {
    return CupertinoListTile(
      leading: Icon(
        icon,
        color: isDestructive ? CupertinoColors.destructiveRed : primary1,
        size: 24,
      ),
      title: Text(
        title,
        style: poppinsRegular.copyWith(
            fontSize: 16,
            color: isDestructive ? CupertinoColors.destructiveRed : textColor),
      ),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: poppinsRegular.copyWith(
                  fontSize: 14, color: CupertinoColors.systemGrey))
          : null,
      trailing: isToggle
          ? CupertinoSwitch(
              value: toggleValue,
              onChanged: onToggleChanged,
              activeTrackColor: primary1,
            )
          : const Icon(
              CupertinoIcons.chevron_right,
              color: CupertinoColors.systemGrey,
              size: 16,
            ),
      onTap: onTap,
    );
  }

  Widget _buildPreferenceHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 8),
      child: Text(
        title,
        style: poppinsRegular.copyWith(
          fontSize: 12,
          color: CupertinoColors.systemGrey,
        ),
      ),
    );
  }

  Widget _buildRangeSliderItem({
    required String title,
    required double minValue,
    required double maxValue,
    required ValueChanged<double> onMinChanged,
    required ValueChanged<double> onMaxChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: poppinsRegular.copyWith(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              // Min value text
              SizedBox(
                width: 30,
                child: Text(
                  '${minValue.round()}',
                  style: poppinsRegular.copyWith(fontSize: 14),
                ),
              ),
              // Range slider
              Expanded(
                child: Material(
                  type: MaterialType.transparency,
                  child: RangeSlider(
                    values: RangeValues(minValue, maxValue),
                    min: 60,
                    max: 200,
                    divisions: 140, // For 1-unit increments
                    activeColor: primary1,
                    inactiveColor: CupertinoColors.systemGrey5,
                    onChanged: (RangeValues values) {
                      onMinChanged(values.start);
                      onMaxChanged(values.end);
                    },
                  ),
                ),
              ),
              // Max value text
              SizedBox(
                width: 30,
                child: Text(
                  '${maxValue.round()}',
                  style: poppinsRegular.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionSheetItem({
    required String title,
    required String selectedValue,
    required List<String> options,
    required ValueChanged<String> onChanged,
  }) {
    return CupertinoListTile(
      title: Text(
        title,
        style: poppinsRegular.copyWith(fontSize: 16),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            selectedValue,
            style: poppinsRegular.copyWith(
              fontSize: 16,
              color: CupertinoColors.systemGrey,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            CupertinoIcons.chevron_right,
            color: CupertinoColors.systemGrey,
            size: 16,
          ),
        ],
      ),
      onTap: () {
        _showActionSheet(context, options, selectedValue, onChanged);
      },
    );
  }

  void _showActionSheet(
    BuildContext context,
    List<String> options,
    String selectedValue,
    ValueChanged<String> onChanged,
  ) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          actions: options.map((String option) {
            return CupertinoActionSheetAction(
              onPressed: () {
                onChanged(option);
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    option,
                    style: poppinsRegular.copyWith(fontSize: 16),
                  ),
                  if (option == selectedValue)
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
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: poppinsRegular.copyWith(
                fontSize: 16,
                color: CupertinoColors.destructiveRed,
              ),
            ),
          ),
        );
      },
    );
  }
}
