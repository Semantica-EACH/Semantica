import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';

import '../../../../mocks/component_mock.dart';

void main() {
  group('ComponentState', () {
    test('ComponentInitial should be a subclass of ComponentState', () {
      expect(ComponentInitial(), isA<ComponentState>());
    });

    test('ComponentUpdated should be a subclass of ComponentState', () {
      final components = <Component>[];
      final centralComponent = TestComponent(title: 'Central');
      final state = ComponentUpdated(components, centralComponent);

      expect(state, isA<ComponentState>());
      expect(state.sidebarComponents, components);
      expect(state.centralComponent, centralComponent);
    });

    test('ComponentUpdated should handle null centralComponent', () {
      final components = <Component>[];
      final state = ComponentUpdated(components, null);

      expect(state, isA<ComponentState>());
      expect(state.sidebarComponents, components);
      expect(state.centralComponent, isNull);
    });
  });
}
