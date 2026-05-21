import 'package:flutter_dotenv/flutter_dotenv.dart';

String get apiKey {
  final v = dotenv.env['API_KEY']?.trim();
  if (v == null || v.isEmpty) {
    throw StateError(
      'Missing API_KEY in .env. Copy .env.example to .env and add your key.',
    );
  }
  return v;
}
