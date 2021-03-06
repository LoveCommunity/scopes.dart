
import 'package:test/test.dart';
import 'package:scopes/scopes.dart';

import '../shared/states_tester.dart';

void main() {

  test('`states.cache` connect when observers increase to one', () {

    int invokes = 0;

    final states = States<String>((setState) {
      setState('a');
      invokes += 1;
      return Disposable.empty;
    });

    final cache = states.cache();

    expect(invokes, 0);
    final observation1 = cache.observe((_) {});
    expect(invokes, 1);
    final observation2 = cache.observe((_) {});
    expect(invokes, 1);

    observation1.dispose();
    observation2.dispose();

  });

  test('`states.cache` disconnect when observers decrease to zero', () {

    int invokes = 0;

    final states = States<String>((setState) {
      setState('a');
      return Disposable(() {
        invokes += 1;
      });
    });

    final cache = states.cache();

    final observation1 = cache.observe((_) {});
    final observation2 = cache.observe((_) {});

    expect(invokes, 0);
    observation1.dispose();
    expect(invokes, 0);
    observation2.dispose();
    expect(invokes, 1);

  });

  test('`states.cache` forward data to observers', () async {

    final states = States<String>((setState) {
      setState('a');
      Future(() => setState('b'));
      return Disposable.empty;
    });

    final cache = states.cache();

    final tester1 = StatesTester(
      cache,
    ); 

    final tester2 = StatesTester(
      cache,
    ); 


    tester1.startObserve();
    tester2.startObserve();
    
    expect(tester1.recorded, [
      'a',
    ]);
    expect(tester2.recorded, [
      'a',
    ]);
    await Future(() {});
    expect(tester1.recorded, [
      'a',
      'b',
    ]);
    expect(tester2.recorded, [
      'a',
      'b',
    ]);

    tester1.stopObserve();
    tester2.stopObserve();

  });

  test('`states.cache` replay data to observers', () {

    final states = States<String>((setState) {
      setState('a');
      setState('b');
      setState('c');
      return Disposable.empty;
    });

    final cache = states.cache();

    final tester = StatesTester(
      cache,
    );

    final observation  = cache.observe((_) {});

    expect(tester.recorded, <String>[]);
    tester.startObserve();
    expect(tester.recorded, [
      'c',
    ]);

    tester.stopObserve();
    observation.dispose();

  });

}
