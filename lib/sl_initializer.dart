// ignore_for_file: invalid_annotation_target

import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'core/env/environment.dart';
import 'sl_initializer.config.dart';

@InjectableInit(
  initializerName: r'$init',
  asExtension: false,
  includeMicroPackages: false,
  ignoreUnregisteredTypes: [EnvConfig],
)
abstract final class SLInitializer {
  static Completer<void> _initCompleter = Completer<void>();

  static Future<void> get initFuture => _initCompleter.future;

  static Future<void> init(GetIt getIt) async {
    if (_initCompleter.isCompleted) return;
    $init(getIt);
    _initCompleter.complete();
  }

  static Future<void> reset(GetIt getIt) async {
    _initCompleter = Completer<void>();
    await getIt.reset();
  }
}
