import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppEnvironment {
  development,
  staging,
  production,
}

class EnvConfig {
  final AppEnvironment environment;
  final String supabaseUrl;
  final String supabaseAnonKey;

  const EnvConfig({
    required this.environment,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
  });

  factory EnvConfig.fromDotEnv(AppEnvironment env) {
    return EnvConfig(
      environment: env,
      supabaseUrl: dotenv.get('SUPABASE_URL', fallback: ''),
      supabaseAnonKey: dotenv.get('SUPABASE_ANON_KEY', fallback: ''),
    );
  }

  bool get isDev => environment == AppEnvironment.development;
  bool get isStaging => environment == AppEnvironment.staging;
  bool get isProd => environment == AppEnvironment.production;
}
