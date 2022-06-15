
import 'package:test/test.dart';
import 'package:scopes/scopes.dart';

import '../../toolbox/driver_tester.dart';

void main() {

  test('`driver.cast` success', () {

    final driver = Driver<String>((onData) {
      onData('a');
      return Disposable.empty;
    });

    final cast = driver.cast<Object>();

    final tester = DriverTester(
      cast,
    );

    expect(tester.recorded, []);
    tester.startDrive();
    expect(tester.recorded, [
      'a',
    ]);

    tester.stopDrive();

  });


  test('`driver.cast` failure', () {

    final driver = Driver<String>((onData) {
      onData('a');
      return Disposable.empty;
    });

    final cast = driver.cast<int>();

    expect(
      () {
        cast.drive((data) {});
      },
      throwsA(
        isA<TypeError>()
      ),
    );

  });
}
