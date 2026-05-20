import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_reader_app/core/theme/theme_notifier.dart';
import 'package:news_reader_app/feature/news/data/local_datasource/hive_boxes.dart';

@RoutePage()
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(themeNotifierProvider).value ?? ThemeMode.system;
    final fontSize = ref.watch(fontSizeNotifierProvider).value ?? 16.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Theme',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              if (value) {
                ref.read(themeNotifierProvider.notifier).setDark();
              } else {
                ref.read(themeNotifierProvider.notifier).setLight();
              }
            },
          ),
          const SizedBox(height: 24),
          const Text(
            'Font Size',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Slider(
            min: 14,
            max: 24,
            divisions: 5,
            label: fontSize.toStringAsFixed(0),
            value: fontSize.clamp(14, 24),
            onChanged: (value) {
              ref.read(fontSizeNotifierProvider.notifier).setFontSize(value);
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Current font size: ${fontSize.toStringAsFixed(0)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Cache',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            icon: const Icon(Icons.delete_outline),
            label: const Text('Clear cached news'),
            onPressed: () async {
              await HiveBoxes.clearCache();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Cached news cleared successfully'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
