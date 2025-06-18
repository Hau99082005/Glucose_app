import 'package:flutter/cupertino.dart';
import 'package:flutter_app/src/core/services/auth_service.dart';
import 'package:flutter_app/src/core/services/notification_service.dart';
import 'package:flutter_app/src/core/widgets/auth_wrapper.dart';
import 'package:flutter_app/src/core/utils/auto_router_setup/auto_router.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/src/core/providers/health_record_provider.dart';
import 'package:flutter_app/src/core/providers/reminder_provider.dart';
import 'package:flutter_app/src/features/medications/providers/medication_provider.dart';
import 'package:flutter_app/src/core/services/preferences_service.dart';

// Global navigator key for accessing context from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final appRouter = AppRouter();

  await NotificationService().initialize();

  runApp(
    MultiProvider(
      providers: [
        Provider<SharedPreferences>.value(value: prefs),
        Provider<AuthService>(create: (_) => AuthService(prefs)),
        Provider<PreferencesService>(create: (_) => PreferencesService(prefs)),
        ChangeNotifierProvider(create: (_) => HealthRecordProvider()),
        ChangeNotifierProvider(create: (_) => ReminderProvider()),
        ChangeNotifierProvider(create: (_) => MedicationProvider()),
      ],
      child: MyApp(appRouter: appRouter),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return AuthWrapper(
      child: CupertinoApp.router(
        title: 'Glucose Blood Sugar Tracker by DrLogs TM',
        theme: const CupertinoThemeData(
          primaryColor: CupertinoColors.activeBlue,
        ),
        routerDelegate: appRouter.delegate(
          navigatorObservers: () => [AutoRouteObserver()],
        ),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
