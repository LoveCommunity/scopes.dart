
import 'package:test/test.dart';
import 'package:scopes/scopes.dart';

import '../shared/observable_tester.dart';

void main() {

  test('`observable.cast` success', () {

    final observable = Observable<String>((onData) {
      onData('a');
      return Disposable.empty;
    }); 

    final cast = observable.cast<Object>();

    final tester = ObservableTester(
      cast,
    );

    expect(tester.recorded, <String>[]);
    tester.startObserve();
    expect(tester.recorded, [
      'a',
    ]);

    tester.stopObserve();
  });

  test('`observable.cast` failure', () {

    final observable = Observable<String>((onData) {
      onData('a');
      return Disposable.empty;
    });

    final cast = observable.cast<int>();

    expect(
      () {
        cast.observe((_) {});
      },
      throwsA(
        isA<TypeError>()
      ),
    );
  });
}
