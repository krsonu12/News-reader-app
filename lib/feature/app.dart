
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/routes/app_router.dart';
import 'package:news_reader_app/core/theme/app_theme.dart';
import 'package:news_reader_app/core/theme/theme_notifier.dart';

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
