import 'package:flutter_app/src/core/utils/constants/app_constants.dart';

class EnvironmentConfig {
  static const String BUILD_VARIANT = String.fromEnvironment('BUILD_VARIANT',
      defaultValue: devEnvironmentString);
}
