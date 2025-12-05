import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/env/environment.dart';
import 'bootstrap.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env.production');
  await bootstrap(AppEnvironment.production);
}
