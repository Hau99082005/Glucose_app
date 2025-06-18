import 'package:flutter/cupertino.dart';
import 'package:health/health.dart';
import 'package:flutter_app/src/core/utils/values/colors.dart';
import 'package:flutter_app/src/core/utils/values/styles.dart';
import 'package:flutter_app/src/core/services/health_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class HealthSettingsPage extends StatefulWidget {
  final bool isModal;
  final bool isAndroid;

  const HealthSettingsPage({
    super.key,
    this.isModal = false,
    this.isAndroid = false,
  });

  @override
  State<HealthSettingsPage> createState() => _HealthSettingsPageState();
}

class _HealthSettingsPageState extends State<HealthSettingsPage> {
  final HealthService _healthService = HealthService();
  bool _isLoading = false;
  bool _hasRequestedPermission = false;

  // Blood Glucose settings
  bool _bloodGlucoseSyncEnabled = false;
  bool _bloodGlucoseReadEnabled = false;
  bool _bloodGlucoseWriteEnabled = false;

  // Blood Pressure settings
  bool _bloodPressureSyncEnabled = false;
  bool _bloodPressureReadEnabled = false;
  bool _bloodPressureWriteEnabled = false;

  // Weight settings
  bool _weightSyncEnabled = false;
  bool _weightReadEnabled = false;
  bool _weightWriteEnabled = false;

  final types = [
    HealthService.bloodGlucoseType,
    HealthService.bloodPressureTypeSystolic,
    HealthService.bloodPressureTypeDiastolic,
    HealthService.heartRateType,
    HealthService.weightType,
  ];

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadPermissionStatus();
  }

  Future<void> _loadPermissionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    _hasRequestedPermission =
        prefs.getBool('hasRequestedHealthPermission') ?? false;
  }

  Future<void> _savePermissionStatus() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasRequestedHealthPermission', true);
    _hasRequestedPermission = true;
  }

  Future<void> _loadSettings() async {
    setState(() => _isLoading = true);

    try {
      // Check permissions for each type individually
      var bloodGlucoseWriteEnabled = await _healthService.hasPermissions(
          [HealthService.bloodGlucoseType], [HealthDataAccess.WRITE]);

      var bloodPressureWriteEnabled = await _healthService.hasPermissions([
        HealthService.bloodPressureTypeSystolic,
        HealthService.bloodPressureTypeDiastolic,
        HealthService.heartRateType
      ], [
        HealthDataAccess.WRITE,
        HealthDataAccess.WRITE,
        HealthDataAccess.WRITE
      ]);

      var weightWriteEnabled = await _healthService
          .hasPermissions([HealthService.weightType], [HealthDataAccess.WRITE]);

      setState(() {
        _bloodGlucoseSyncEnabled = bloodGlucoseWriteEnabled;
        _bloodPressureSyncEnabled = bloodPressureWriteEnabled;
        _weightSyncEnabled = weightWriteEnabled;

        _bloodGlucoseReadEnabled = bloodGlucoseWriteEnabled;
        _bloodGlucoseWriteEnabled = bloodGlucoseWriteEnabled;
        _bloodPressureReadEnabled = bloodPressureWriteEnabled;
        _bloodPressureWriteEnabled = bloodPressureWriteEnabled;
        _weightReadEnabled = weightWriteEnabled;
        _weightWriteEnabled = weightWriteEnabled;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _requestAuthorization() async {
    setState(() => _isLoading = true);

    try {
      // First check if health is available
      final isAvailable = await _healthService.isHealthAvailable();
      if (!isAvailable) {
        if (mounted) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Health Not Available'),
              content: Text(
                widget.isAndroid
                    ? 'Google Fit is not available on this device.'
                    : 'Apple Health is not available on this device.',
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        }
        return;
      }

      // Request authorization
      final authorized = await _healthService.requestAuthorization(types);

      if (authorized) {
        setState(() => _isLoading = true);
        await _savePermissionStatus();
        await _loadSettings();
        await _healthService.syncHealthData(context);
        setState(() => _isLoading = false);
      } else {
        if (mounted) {
          showCupertinoDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text('Authorization Required'),
              content: Text(
                widget.isAndroid
                    ? 'Please enable health data access in your device settings. Go to Settings > Apps > ${widget.isAndroid ? 'Google Fit' : 'Health'} > Permissions.'
                    : 'Please enable health data access in your device settings. Go to Settings > Privacy > Health.',
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Open Settings'),
                  onPressed: () {
                    Navigator.pop(context);
                    _healthService.openHealthSettings();
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        }
      }
    } catch (e) {
      debugPrint('Error requesting health authorization: $e');
      if (mounted) {
        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text('Error'),
            content:
                Text('Failed to request health permissions: ${e.toString()}'),
            actions: [
              CupertinoDialogAction(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.systemGrey5,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: primary1,
        middle: Text(
          widget.isAndroid ? 'Google Health Settings' : 'Apple Health Settings',
          style: poppinsRegular.copyWith(
            fontSize: 18,
            color: white,
          ),
        ),
        leading: widget.isModal
            ? CupertinoButton(
                padding: const EdgeInsets.all(4),
                child: Icon(CupertinoIcons.xmark, color: white, size: 24),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        trailing: _hasRequestedPermission
            ? CupertinoButton(
                padding: const EdgeInsets.all(4),
                child: Icon(CupertinoIcons.arrow_2_circlepath,
                    color: white, size: 24),
                onPressed: () async {
                  setState(() => _isLoading = true);
                  await _healthService.syncHealthData(context);
                  setState(() => _isLoading = false);
                },
              )
            : null,
      ),
      child: SafeArea(
        child: _isLoading
            ? const Center(child: CupertinoActivityIndicator())
            : _hasRequestedPermission
                ? ListView(
                    children: [
                      // Blood Glucose Section
                      _buildSection(
                        'Blood Glucose',
                        [
                          _buildToggleRow(
                            'Blood Glucose Sync Enabled',
                            _bloodGlucoseSyncEnabled,
                            (value) {
                              setState(() {
                                _bloodGlucoseSyncEnabled = value;
                                _bloodGlucoseReadEnabled = value;
                                _bloodGlucoseWriteEnabled = value;
                              });
                            },
                          ),
                          if (_bloodGlucoseSyncEnabled) ...[
                            _buildToggleRow(
                              'Read Enabled',
                              _bloodGlucoseReadEnabled,
                              (value) {
                                setState(() {
                                  _bloodGlucoseReadEnabled = value;
                                });
                              },
                            ),
                            _buildToggleRow(
                              'Write Enabled',
                              _bloodGlucoseWriteEnabled,
                              (value) {
                                setState(() {
                                  _bloodGlucoseWriteEnabled = value;
                                });
                              },
                            ),
                          ],
                        ],
                      ),

                      // Blood Pressure Section
                      _buildSection(
                        'Blood Pressure',
                        [
                          _buildToggleRow(
                            'Blood Pressure Sync Enabled',
                            _bloodPressureSyncEnabled,
                            (value) {
                              setState(() {
                                _bloodPressureSyncEnabled = value;
                                _bloodPressureReadEnabled = value;
                                _bloodPressureWriteEnabled = value;
                              });
                            },
                          ),
                          if (_bloodPressureSyncEnabled) ...[
                            _buildToggleRow(
                              'Read Enabled',
                              _bloodPressureReadEnabled,
                              (value) {
                                setState(() {
                                  _bloodPressureReadEnabled = value;
                                });
                              },
                            ),
                            _buildToggleRow(
                              'Write Enabled',
                              _bloodPressureWriteEnabled,
                              (value) {
                                setState(() {
                                  _bloodPressureWriteEnabled = value;
                                });
                              },
                            ),
                          ],
                        ],
                      ),

                      // Weight Section
                      _buildSection(
                        'Weight',
                        [
                          _buildToggleRow(
                            'Weight Sync Enabled',
                            _weightSyncEnabled,
                            (value) {
                              setState(() {
                                _weightSyncEnabled = value;
                                _weightReadEnabled = value;
                                _weightWriteEnabled = value;
                              });
                            },
                          ),
                          if (_weightSyncEnabled) ...[
                            _buildToggleRow(
                              'Read Enabled',
                              _weightReadEnabled,
                              (value) {
                                setState(() {
                                  _weightReadEnabled = value;
                                });
                              },
                            ),
                            _buildToggleRow(
                              'Write Enabled',
                              _weightWriteEnabled,
                              (value) {
                                setState(() {
                                  _weightWriteEnabled = value;
                                });
                              },
                            ),
                          ],
                        ],
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          widget.isAndroid
                              ? CupertinoIcons.heart
                              : CupertinoIcons.heart_fill,
                          size: 64,
                          color: primary1,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.isAndroid ? 'Google Fit' : 'Apple Health',
                          style: poppinsMedium.copyWith(
                            fontSize: 24,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        const SizedBox(height: 32),
                        CupertinoButton(
                          color: primary1,
                          onPressed: _requestAuthorization,
                          child: Text(
                            'Sync with ${widget.isAndroid ? 'Google Fit' : 'Apple Health'}',
                            style: poppinsRegular.copyWith(
                              color: white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      color: redCF3A3A,
      margin: const EdgeInsets.only(top: 16),
      child: CupertinoListSection.insetGrouped(
        backgroundColor: CupertinoColors.lightBackgroundGray,
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

  Widget _buildToggleRow(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return CupertinoListTile(
      title: Text(
        title,
        style: poppinsRegular.copyWith(fontSize: 16),
      ),
      trailing: CupertinoSwitch(
        value: value,
        onChanged: onChanged,
        activeTrackColor: primary1,
      ),
    );
  }
}
