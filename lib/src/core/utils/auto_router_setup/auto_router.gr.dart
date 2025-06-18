// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/cupertino.dart' as _i11;
import 'package:flutter_app/src/core/entities/health_record.dart' as _i12;
import 'package:flutter_app/src/features/graph/presentations/pages/graph_page.dart'
    as _i3;
import 'package:flutter_app/src/features/home/presentation/pages/create_record_page.dart'
    as _i1;
import 'package:flutter_app/src/features/home/presentation/pages/history_page.dart'
    as _i4;
import 'package:flutter_app/src/features/home/presentation/pages/home_page.dart'
    as _i5;
import 'package:flutter_app/src/features/home/presentation/pages/reminders_page.dart'
    as _i8;
import 'package:flutter_app/src/features/insights/presentations/pages/create_report_page.dart'
    as _i2;
import 'package:flutter_app/src/features/insights/presentations/pages/insights_page.dart'
    as _i6;
import 'package:flutter_app/src/features/medications/presentations/pages/medications_page.dart'
    as _i7;
import 'package:flutter_app/src/features/settings/pages/settings_page.dart'
    as _i9;

abstract class $AppRouter extends _i10.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    CreateRecordRoute.name: (routeData) {
      final args = routeData.argsAs<CreateRecordRouteArgs>();
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.CreateRecordPage(
          key: args.key,
          initialType: args.initialType,
          record: args.record,
        ),
      );
    },
    CreateReportRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.CreateReportPage(),
      );
    },
    GraphRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.GraphPage(),
      );
    },
    HistoryRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.HistoryPage(),
      );
    },
    HomeRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<HomeRouteArgs>(
          orElse: () =>
              HomeRouteArgs(tabIndex: queryParams.optInt('tabIndex')));
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.HomePage(
          key: args.key,
          tabIndex: args.tabIndex,
        ),
      );
    },
    InsightsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.InsightsPage(),
      );
    },
    MedicationsRoute.name: (routeData) {
      final args = routeData.argsAs<MedicationsRouteArgs>(
          orElse: () => const MedicationsRouteArgs());
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.MedicationsPage(isModal: args.isModal),
      );
    },
    RemindersRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.RemindersPage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i10.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.SettingsPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.CreateRecordPage]
class CreateRecordRoute extends _i10.PageRouteInfo<CreateRecordRouteArgs> {
  CreateRecordRoute({
    _i11.Key? key,
    required String initialType,
    _i12.HealthRecord? record,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          CreateRecordRoute.name,
          args: CreateRecordRouteArgs(
            key: key,
            initialType: initialType,
            record: record,
          ),
          initialChildren: children,
        );

  static const String name = 'CreateRecordRoute';

  static const _i10.PageInfo<CreateRecordRouteArgs> page =
      _i10.PageInfo<CreateRecordRouteArgs>(name);
}

class CreateRecordRouteArgs {
  const CreateRecordRouteArgs({
    this.key,
    required this.initialType,
    this.record,
  });

  final _i11.Key? key;

  final String initialType;

  final _i12.HealthRecord? record;

  @override
  String toString() {
    return 'CreateRecordRouteArgs{key: $key, initialType: $initialType, record: $record}';
  }
}

/// generated route for
/// [_i2.CreateReportPage]
class CreateReportRoute extends _i10.PageRouteInfo<void> {
  const CreateReportRoute({List<_i10.PageRouteInfo>? children})
      : super(
          CreateReportRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateReportRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i3.GraphPage]
class GraphRoute extends _i10.PageRouteInfo<void> {
  const GraphRoute({List<_i10.PageRouteInfo>? children})
      : super(
          GraphRoute.name,
          initialChildren: children,
        );

  static const String name = 'GraphRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HistoryPage]
class HistoryRoute extends _i10.PageRouteInfo<void> {
  const HistoryRoute({List<_i10.PageRouteInfo>? children})
      : super(
          HistoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'HistoryRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i10.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i11.Key? key,
    int? tabIndex,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            tabIndex: tabIndex,
          ),
          rawQueryParams: {'tabIndex': tabIndex},
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i10.PageInfo<HomeRouteArgs> page =
      _i10.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    this.tabIndex,
  });

  final _i11.Key? key;

  final int? tabIndex;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, tabIndex: $tabIndex}';
  }
}

/// generated route for
/// [_i6.InsightsPage]
class InsightsRoute extends _i10.PageRouteInfo<void> {
  const InsightsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          InsightsRoute.name,
          initialChildren: children,
        );

  static const String name = 'InsightsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MedicationsPage]
class MedicationsRoute extends _i10.PageRouteInfo<MedicationsRouteArgs> {
  MedicationsRoute({
    bool isModal = false,
    List<_i10.PageRouteInfo>? children,
  }) : super(
          MedicationsRoute.name,
          args: MedicationsRouteArgs(isModal: isModal),
          initialChildren: children,
        );

  static const String name = 'MedicationsRoute';

  static const _i10.PageInfo<MedicationsRouteArgs> page =
      _i10.PageInfo<MedicationsRouteArgs>(name);
}

class MedicationsRouteArgs {
  const MedicationsRouteArgs({this.isModal = false});

  final bool isModal;

  @override
  String toString() {
    return 'MedicationsRouteArgs{isModal: $isModal}';
  }
}

/// generated route for
/// [_i8.RemindersPage]
class RemindersRoute extends _i10.PageRouteInfo<void> {
  const RemindersRoute({List<_i10.PageRouteInfo>? children})
      : super(
          RemindersRoute.name,
          initialChildren: children,
        );

  static const String name = 'RemindersRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SettingsPage]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute({List<_i10.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i10.PageInfo<void> page = _i10.PageInfo<void>(name);
}
