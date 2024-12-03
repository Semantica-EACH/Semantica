import 'package:semantica/features/component_list/domain/entities/central_stack.dart';
import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component_list/domain/entities/side_list.dart';

class MinimizeComponentUseCase {
  /// Atualiza os estados dos componentes para minimizar um
  void call({
    required Component? component,
    required SideList sideList,
    required CentralStack centralStack,
  }) {
    if (component == null) return;

    // Remove o componente da área central
    centralStack.removeComponent(component);

    // Adiciona o componente à barra lateral
    sideList.addComponent(component);
  }
}
