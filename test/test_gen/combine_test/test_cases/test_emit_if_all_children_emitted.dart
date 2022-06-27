
import '../../shared/codes.dart';
import '../shared/codes.dart';

String testObservableCombineEmitIfAllChildrenEmitted(int? number) {
  final count = number ?? 2;
  return '''
    test('${observableCombineTestHeader(number)} emit if all children emitted', () async {
      ${[
        ...observables(count, _observable),
        observableCombine(number),
        observableTester(),
        testerStartObserve(),
        expectTesterRecorded([]),
        awaitEmptyFuture(),
        expectTesterRecorded(_expects(count)),
        testerStopObserve(),
      ].join('\n')}
    });
  ''';
}

String _observable(bool isLast, int n) {
  final onData = "onData('${n}a')";
  return '''
    final observable$n = Observable<String>((onData) {
      ${!isLast
        ? "$onData;"
        : "Future(() => $onData);" 
      }
      return Disposable.empty;
    });
  ''';
}

List<String> _expects(int count) => [
  joinAllA(count), // '1a|2a'
];

String testStatesCombineInitialEmit(int? number) {
  final count = number ?? 2;
  return '''
    test('${statesCombineTestHeader(number)} initial emit', () {
      ${[
        ...states_iterable(count, _states),
        statesCombine(number),
        statesTester(),
        expectTesterRecorded([]),
        testerStartObserve(),
        expectTesterRecorded(_expects(count)),
        testerStopObserve(),
      ].join('\n')}
    });
  ''';
}

String _states(bool isLast, int n) {
  return '''
    final states$n = States<String>((setState) {
      setState('${n}a');
      return Disposable.empty;
    });
  ''';
}
