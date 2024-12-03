import 'package:semantica/features/component_list/domain/entities/central_stack.dart';
import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component_list/domain/entities/side_list.dart';

class MaximizeComponentUseCase {
  /// Atualiza os estados dos componentes para maximizar um
  void call(
      {required Component component,
      required SideList sideList,
      required CentralStack centralStack}) {
    // Verifica se o componente está na barra lateral
    if (!sideList.components.contains(component)) {
      throw Exception('Componente não encontrado na barra lateral');
    }

    // Remove o componente da barra lateral
    sideList.removeComponent(component);

    // Adiciona o componente à área central
    centralStack.addComponent(component);
  }
}
