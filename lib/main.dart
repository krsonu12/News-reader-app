import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_reader_app/core/routes/app_router.dart';
import 'package:news_reader_app/core/theme/app_theme.dart';
import 'package:news_reader_app/core/theme/theme_notifier.dart';
import 'package:news_reader_app/feature/news/data/local_datasource/hive_boxes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  await HiveBoxes.openAll();
  runApp(
    ProviderScope(
      child: MyApp(appRouter: AppRouter(navigatorKey: navigatorKey)),
    ),
  );
}

// Global navigator key 
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerWidget {
  final AppRouter appRouter;
  const MyApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(themeNotifierProvider).value ?? ThemeMode.system;
    final fontSize = ref.watch(fontSizeNotifierProvider).value ?? 16.0;

    return MaterialApp.router(
      title: 'News Reader',
      theme: AppTheme.lightTheme(fontSize),
      darkTheme: AppTheme.darkTheme(fontSize),
      themeMode: themeMode,
      routeInformationParser: appRouter.defaultRouteParser(),
      routerDelegate: appRouter.delegate(),
      debugShowCheckedModeBanner: false,
    );
  }
}
