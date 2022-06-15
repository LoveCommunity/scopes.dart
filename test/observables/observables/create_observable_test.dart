
import 'package:test/test.dart';
import 'package:scopes/scopes.dart';

import '../../toolbox/async_toolbox.dart';
import '../../toolbox/observable_tester.dart';

void main() {

  test('`Observable.default` sync', () {
    
    final observable = Observable<String>((onData) {
      onData('a');
      return Disposable.empty;
    });

    final tester = ObservableTester(
      observable,
    );

    expect(tester.recorded, []);
    tester.startObserve();
    expect(tester.recorded, [
      'a',
    ]);

    tester.stopObserve();

  });

  test('`Observable.default` async', () async {

    final observable = Observable<String>((onData) {
      Future<void>(() => onData('a'));
      return Disposable.empty;
    });

    final tester = ObservableTester(
      observable,
    );

    expect(tester.recorded, []);
    tester.startObserve();
    expect(tester.recorded, []);

    await delayed(30);
    expect(tester.recorded, [
      'a',
    ]);

    tester.stopObserve();

  });

  test('`Observable.default` observation dispose', () {

    int invoked = 0;

    final observable = Observable<String>((onData) {
      return Disposable(() {
        invoked += 1;
      });
    });

    final observation = observable.observe((data) {});

    expect(invoked, 0);
    observation.dispose();
    expect(invoked, 1);
  });

  test('`Observable.default` not recieve data after disposed', () async {

    final observable = Observable<String>((onData) {
      onData('a');
      Future<void>(() => onData('b'));
      return Disposable.empty;
    });
    
    final tester = ObservableTester(
      observable,
    )..startObserve();

    expect(tester.recorded, [
      'a',
    ]);
    
    tester.stopObserve();

    await delayed(30);
    expect(tester.recorded, [
      'a',
    ]);
    
  });


}
