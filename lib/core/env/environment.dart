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
  final String supabaseRedirectUrl;

  const EnvConfig({
    required this.environment,
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.supabaseRedirectUrl,
  });

  factory EnvConfig.fromDotEnv(AppEnvironment env) {
    return EnvConfig(
      environment: env,
      supabaseUrl: dotenv.get('SUPABASE_URL', fallback: ''),
      supabaseAnonKey: dotenv.get('SUPABASE_ANON_KEY', fallback: ''),
      supabaseRedirectUrl: dotenv.get('SUPABASE_REDIRECT_URL', fallback: ''),
    );
  }

  bool get isDev => environment == AppEnvironment.development;
  bool get isStaging => environment == AppEnvironment.staging;
  bool get isProd => environment == AppEnvironment.production;
}
