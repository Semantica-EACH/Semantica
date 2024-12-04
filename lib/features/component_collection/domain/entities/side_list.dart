import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component_collection/domain/entities/component_collection.dart';

class SideList implements ComponentCollection {
  List<Component> components;

  SideList([List<Component>? initialComponents])
      : components = initialComponents ?? [];

  // Adiciona um novo componente à lista
  @override
  void addComponent(Component component) {
    if (!components.contains(component)) {
      components.add(component);
    }
  }

  // Insere um componente em uma posição específica da lista
  void insertComponentAt(Component component, int index) {
    if (index < 0 || index > components.length) {
      throw RangeError.index(
          index, components, 'index', null, components.length);
    }
    if (!components.contains(component)) {
      components.insert(index, component);
    }
  }

  // Remove um componente da lista
  @override
  void removeComponent(Component component) {
    components.remove(component);
  }
}
