import 'dart:async';

import '../scopes/configurable_scope.dart';
import 'combine_configurable.dart';
import 'configurable_function.dart';

typedef ScopeConfigure = FutureOr<void> Function(ConfigurableScope scope);

abstract class Configurable {
  FutureOr<void> configure(ConfigurableScope scope);

  const factory Configurable(ScopeConfigure configure) = ConfigurableFunction;
  const factory Configurable.combine({
    required List<Configurable> children,
  }) = CombineConfigurable;
}

