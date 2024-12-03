import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/component_list/domain/entities/central_stack.dart';
import 'package:semantica/features/component/domain/usecases/open_component_usecase.dart';

import '../../../../mocks/component_mock.dart';

void main() {
  test('deve adicionar um componente à área central', () {
    final component = TestComponent(title: "Titulo");
    final centralStack = CentralStack();
    final useCase = OpenComponentUseCase();

    useCase.call(component: component, componentList: centralStack);

    expect(centralStack.components.contains(component), true);
  });
}
