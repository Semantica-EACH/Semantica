import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/component/domain/usecases/maximize_component_usecase.dart';
import 'package:semantica/features/component_list/domain/entities/central_stack.dart';
import 'package:semantica/features/component_list/domain/entities/side_list.dart';

import '../../../../mocks/component_mock.dart';

void main() {
  group('MaximizeComponentUseCase', () {
    final maximizeComponentUseCase = MaximizeComponentUseCase();

    test('deve maximizar o componente e atualizar a barra lateral', () {
      // Arrange
      final sidebarComponents = [
        TestComponent(title: 'Componente 1'),
        TestComponent(title: 'Componente 2'),
        TestComponent(title: 'Componente 3'),
      ];
      const title = 'Componente 2';

      final sideList = SideList(sidebarComponents);
      final centralStack = CentralStack();

      // Act
      maximizeComponentUseCase.call(
        component: TestComponent(title: title),
        sideList: sideList,
        centralStack: centralStack,
      );

      // Assert
      expect(centralStack.components.last.title, equals(title));
      expect(sideList.components.length, equals(2));
      expect(sideList.components.any((component) => component.title == title),
          isFalse);
    });

    test('deve lançar exceção se o componente não for encontrado', () {
      // Arrange
      final sidebarComponents = [
        TestComponent(title: 'Componente 1'),
        TestComponent(title: 'Componente 3'),
      ];
      const title = 'Componente 2';

      final sideList = SideList(sidebarComponents);
      final centralStack = CentralStack();

      // Act & Assert
      expect(
        () => maximizeComponentUseCase.call(
          component: TestComponent(title: title),
          sideList: sideList,
          centralStack: centralStack,
        ),
        throwsException,
      );
    });
  });

  test(
      'deve remover um componente da barra lateral e adicioná-lo à área central',
      () {
    final component = TestComponent(title: "Title");
    final sideList = SideList();
    final centralStack = CentralStack();
    final useCase = MaximizeComponentUseCase();

    sideList.addComponent(component);
    useCase.call(
        component: component, sideList: sideList, centralStack: centralStack);

    expect(sideList.components.contains(component), false);
    expect(centralStack.components.contains(component), true);
  });
}
