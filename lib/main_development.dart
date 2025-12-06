import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'bootstrap.dart';
import 'core/env/environment.dart';

Future<void> main() async {
  await _loadEnv('.env.development');
  await bootstrap(AppEnvironment.development);
}

Future<void> _loadEnv(String fileName) async {
  final candidates = [fileName, '.env.example'];
  for (final candidate in candidates) {
    try {
      await dotenv.load(fileName: candidate);
      if (candidate != fileName) {
        debugPrint(
          'Loaded fallback env file $candidate. Copy it to $fileName and fill Supabase config.',
        );
      }
      return;
    } catch (_) {
      // try next candidate
    }
  }
  debugPrint(
    'No env file found. Create $fileName from .env.example and add Supabase config.',
  );
}
