import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/component_list/domain/entities/side_list.dart';

import '../../../../mocks/component_mock.dart';

void main() {
  group('SideList', () {
    test('addComponent adds a component to the list', () {
      final sideList = SideList([]);
      final component = TestComponent(title: 'Component 1');

      sideList.addComponent(component);

      expect(sideList.components, contains(component));
    });

    test('addComponent does not add duplicate components', () {
      final component = TestComponent(title: 'Component 1');
      final sideList = SideList([component]);

      sideList.addComponent(component);

      expect(sideList.components.length, 1);
    });

    test('insertComponentAt inserts a component at the specified index', () {
      final sideList = SideList([]);
      final component = TestComponent(title: 'Component 1');

      sideList.insertComponentAt(component, 0);

      expect(sideList.components[0], component);
    });

    test('insertComponentAt throws RangeError if index is out of bounds', () {
      final sideList = SideList([]);
      final component = TestComponent(title: 'Component 1');

      expect(() => sideList.insertComponentAt(component, 1), throwsRangeError);
    });

    test('removeComponent removes a component from the list', () {
      final component = TestComponent(title: 'Component 1');
      final sideList = SideList([component]);

      sideList.removeComponent(component);

      expect(sideList.components, isNot(contains(component)));
    });
  });
}
