
import 'dart:async';
import 'package:meta/meta.dart';

import '../scopes/configurable_scope.dart';
import '../shared/build_scope.dart';
import 'configurable.dart';

@internal
class CombineConfigurable implements Configurable {

  const CombineConfigurable({
    required List<Configurable> children,
  }): _children = children;

  final List<Configurable> _children;

  @override
  FutureOr<void> configure(ConfigurableScope scope) {
    return configureScope(_children, scope);
  }
}
