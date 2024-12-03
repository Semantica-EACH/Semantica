import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/component_list/domain/entities/central_stack.dart';
import 'package:semantica/features/component/domain/entities/component.dart';

import '../../../../mocks/component_mock.dart';

void main() {
  group('CentralStack', () {
    late CentralStack centralStack;
    late Component component1;
    late Component component2;

    setUp(() {
      centralStack = CentralStack();
      component1 = TestComponent(title: 'Component 1');
      component2 = TestComponent(title: 'Component 2');
    });

    test('initial state', () {
      expect(centralStack.components, isEmpty);
      expect(centralStack.currentIndex, -1);
      expect(centralStack.currentComponent, isNull);
    });

    test('addComponent', () {
      centralStack.addComponent(component1);
      expect(centralStack.components, [component1]);
      expect(centralStack.currentIndex, 0);
      expect(centralStack.currentComponent, component1);

      centralStack.addComponent(component2);
      expect(centralStack.components, [component1, component2]);
      expect(centralStack.currentIndex, 1);
      expect(centralStack.currentComponent, component2);
    });

    test('navigateToPrevious', () {
      centralStack.addComponent(component1);
      centralStack.addComponent(component2);
      centralStack.navigateToPrevious();
      expect(centralStack.currentIndex, 0);
      expect(centralStack.currentComponent, component1);
    });

    test('navigateToNext', () {
      centralStack.addComponent(component1);
      centralStack.addComponent(component2);
      centralStack.navigateToPrevious();
      centralStack.navigateToNext();
      expect(centralStack.currentIndex, 1);
      expect(centralStack.currentComponent, component2);
    });

    test('clear', () {
      centralStack.addComponent(component1);
      centralStack.clear();
      expect(centralStack.components, isEmpty);
      expect(centralStack.currentIndex, -1);
      expect(centralStack.currentComponent, isNull);
    });

    test('getCurrentComponent', () {
      centralStack.addComponent(component1);
      expect(centralStack.getCurrentComponent(), component1);
    });
  });
}
