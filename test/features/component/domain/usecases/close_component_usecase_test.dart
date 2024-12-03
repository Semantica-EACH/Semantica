import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/component/domain/usecases/close_component_usecase.dart';
import 'package:semantica/features/component_list/domain/entities/side_list.dart';
import 'package:semantica/features/component_list/domain/entities/central_stack.dart';

import '../../../../mocks/component_mock.dart';

void main() {
  group('CloseComponentUseCase', () {
    final useCase = CloseComponentUseCase();

    test('deve remover o componente da lista lateral', () {
      TestComponent component = TestComponent(title: "Componente 1");
      final sidebarComponents = SideList([
        component,
        TestComponent(title: 'Componente 2'),
      ]);

      useCase.call(component: component, componentList: sidebarComponents);

      expect(sidebarComponents.components.length, 1);
    });

    test('deve remover o componente da pilha central', () {
      TestComponent component = TestComponent(title: "Componente 1");
      final centralStackComponents = CentralStack([
        component,
        TestComponent(title: 'Componente 2'),
      ]);
      useCase.call(component: component, componentList: centralStackComponents);

      expect(centralStackComponents.components.length, 1);
    });

    test(
        'não deve alterar o componente central se não for o que está sendo fechado',
        () {
      TestComponent component = TestComponent(title: "Componente 1");

      final sidebarComponents = SideList([
        component,
        TestComponent(title: 'Componente 2'),
      ]);
      final centralComponent = CentralStack([component]);

      useCase.call(component: component, componentList: sidebarComponents);

      expect(sidebarComponents.components.length, 1);
      expect(centralComponent.components.length, 1);
    });
  });
}
