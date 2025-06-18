// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_app/src/core/utils/helpers/app_configurations_helper/app_configurations_helper.dart'
    as _i855;
import 'package:flutter_app/src/core/utils/helpers/app_flavor_helper/app_flavors_helper.dart'
    as _i13;
import 'package:flutter_app/src/core/utils/helpers/responsive_ui_helper/responsive_config.dart'
    as _i88;
import 'package:flutter_app/src/features/insights/presentations/insights_view_model.dart'
    as _i973;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i973.InsightsViewModel>(() => _i973.InsightsViewModel());
    gh.singleton<_i88.ResponsiveUiConfig>(() => _i88.ResponsiveUiConfig());
    gh.singleton<_i13.AppFlavorsHelper>(() => _i13.AppFlavorsHelper());
    gh.singleton<_i855.AppConfigurations>(() => _i855.AppConfigurations());
    return this;
  }
}
