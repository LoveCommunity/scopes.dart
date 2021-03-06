
import 'configurables/async_final_test.dart' as async_final_test;
import 'configurables/configurable_combine_test.dart' as configurable_combine_test;
import 'configurables/configurable_compose_test.dart' as configurable_compose_test;
import 'configurables/configurable_function_test.dart' as configurable_function_test;
import 'configurables/final_test.dart' as final_test;
import 'configurables/final_states_test.dart' as final_states_test;
import 'configurables/final_states_convertible_test.dart' as final_states_convertible_test;
import 'scope_methods/disposable_test.dart' as disposable_test;
import 'scope_methods/scope_get_test.dart' as scope_get_test;
import 'scope_methods/scope_push_test.dart' as scope_push_test;
import 'scopes/scope_test.dart' as scope_test;

void main() {
  async_final_test.main();
  configurable_combine_test.main();
  configurable_compose_test.main();
  configurable_function_test.main();
  final_test.main();
  final_states_test.main();
  final_states_convertible_test.main();
  disposable_test.main();
  scope_get_test.main();
  scope_push_test.main();
  scope_test.main();
}
