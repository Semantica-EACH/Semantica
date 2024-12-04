import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component_collection/domain/entities/component_collection.dart';
import 'package:semantica/features/component_collection/domain/entities/central_stack.dart';
import 'package:semantica/features/component_collection/domain/entities/side_list.dart';

class ComponentManager {
  /// Adiciona um novo componente à área central
  void openComponent({
    required Component component,
    required ComponentCollection componentCollection,
  }) {
    componentCollection.addComponent(component);
  }

  /// Remove o componente da lista fornecida
  void closeComponent({
    required Component component,
    required ComponentCollection componentCollection,
  }) {
    componentCollection.removeComponent(component);
  }

  /// Atualiza os estados dos componentes para minimizar um
  void minimizeComponent({
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

  /// Atualiza os estados dos componentes para maximizar um
  void maximizeComponent({
    required Component component,
    required SideList sideList,
    required CentralStack centralStack,
  }) {
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
