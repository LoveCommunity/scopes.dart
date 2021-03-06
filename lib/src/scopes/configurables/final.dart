import 'dart:async';
import 'package:typedef_foundation/typedef_foundation.dart';

import '../scopes/configurable_scope.dart';
import '../shared/expose_in_scope.dart';
import '../shared/typedefs.dart';

import 'configurable.dart';

class Final<T> extends FinalBase<T> {

  const Final({
    Object? name,
    required Equal<T> equal,
    ValueExpose<T>? expose,
    ValueDispose<T>? dispose,
  }): super(
    name: name,
    equal: equal,
    expose: expose,
    dispose: dispose,
    late: false,
  );
}

class LateFinal<T> extends FinalBase<T> {

  const LateFinal({
    Object? name,
    required Equal<T> equal,
    ValueExpose<T>? expose,
    ValueDispose<T>? dispose,
  }): super(
    name: name,
    equal: equal,
    expose: expose,
    dispose: dispose,
    late: true,
  );
}

class FinalBase<T> implements Configurable {

  const FinalBase({
    required Object? name,
    required Equal<T> equal,
    required ValueExpose<T>? expose,
    required ValueDispose<T>? dispose,
    required bool late,
  }): _name = name,
    _equal = equal,
    _expose = expose,
    _dispose = dispose,
    _late = late;

  final Object? _name;
  final Equal<T> _equal;
  final ValueExpose<T>? _expose;
  final ValueDispose<T>? _dispose;
  final bool _late;

  @override
  FutureOr<void> configure(ConfigurableScope scope) {

    final Getter<T> getValue;
    if (!_late) {
      final value = _equal(scope);
      getValue = () => value;
    } else {
      late final value = _equal(scope);
      getValue = () => value;
    }
    
    exposeInScope(
      scope: scope,
      name: _name,
      getValue: getValue,
      expose: _expose,
      dispose: _dispose,
    );
  }
}

