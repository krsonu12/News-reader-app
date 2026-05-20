import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_reader_app/core/theme/app_theme.dart';
import 'package:news_reader_app/core/theme/theme_notifier.dart';
import 'package:news_reader_app/feature/news/data/local/hive_boxes.dart';
import 'package:news_reader_app/feature/news/presentation/screens/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Hive.initFlutter();
  await HiveBoxes.openAll();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider).value ?? ThemeMode.system;
    final fontSize = ref.watch(fontSizeNotifierProvider).value ?? 16.0;

    return MaterialApp(
      title: 'News Reader',
      theme: AppTheme.lightTheme(fontSize),
      darkTheme: AppTheme.darkTheme(fontSize),
      themeMode: themeMode,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
