import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:news_reader_app/core/routes/app_router.dart';
import 'package:news_reader_app/core/storage/hive_boxes.dart';
import 'package:news_reader_app/feature/app.dart';

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
