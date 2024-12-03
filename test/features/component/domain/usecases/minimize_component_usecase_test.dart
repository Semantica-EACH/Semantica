import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/component_list/domain/entities/central_stack.dart';
import 'package:semantica/features/component_list/domain/entities/side_list.dart';
import 'package:semantica/features/component/domain/usecases/minimize_component_usecase.dart';

import '../../../../mocks/component_mock.dart';

void main() {
  late MinimizeComponentUseCase useCase;

  setUp(() {
    useCase = MinimizeComponentUseCase();
  });

  group('MinimizeComponentUseCase', () {
    test('Deve minimizar o componente central se o título corresponder', () {
      // Arrange
      final centralComponent = TestComponent(title: 'Central');
      final sidebarComponents = [TestComponent(title: 'Sidebar1')];
      final centralStack = CentralStack([centralComponent]);
      final sideList = SideList(sidebarComponents);

      // Act
      useCase.call(
          component: centralComponent,
          sideList: sideList,
          centralStack: centralStack);

      // Assert
      expect(centralStack.components.contains(centralComponent), false);
      expect(sideList.components.contains(centralComponent), true);
      expect(sideList.components.length, 2);
    });

    test('Não deve minimizar o componente central se o título não corresponder',
        () {
      // Arrange
      final centralComponent = TestComponent(title: 'Central');
      final sidebarComponents = [TestComponent(title: 'Sidebar1')];
      final centralStack = CentralStack([centralComponent]);
      final sideList = SideList(sidebarComponents);

      // Act
      useCase.call(
          component: TestComponent(title: 'OtherTitle'),
          sideList: sideList,
          centralStack: centralStack);

      // Assert
      expect(centralStack.components.contains(centralComponent), true);
      expect(sideList.components, equals(sidebarComponents));
    });

    test(
        'Deve retornar os componentes inalterados se o componente central for nulo',
        () {
      // Arrange
      final sidebarComponents = [TestComponent(title: 'Sidebar1')];
      final centralStack = CentralStack();
      final sideList = SideList(sidebarComponents);

      // Act
      useCase.call(
          component: null, sideList: sideList, centralStack: centralStack);

      // Assert
      expect(centralStack.components.isEmpty, true);
      expect(sideList.components, equals(sidebarComponents));
    });

    test(
        'Deve remover um componente da área central e adicioná-lo à barra lateral',
        () {
      final component = TestComponent(title: "Title");
      final sideList = SideList([component]);
      final centralStack = CentralStack();
      final useCase = MinimizeComponentUseCase();

      useCase.call(
          component: component, sideList: sideList, centralStack: centralStack);

      expect(sideList.components.contains(component), true);
      expect(centralStack.components.contains(component), false);
    });
  });
}
