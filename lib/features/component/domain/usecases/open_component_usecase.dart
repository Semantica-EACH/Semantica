import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component_list/domain/entities/component_list.dart';

class OpenComponentUseCase {
  /// Adiciona um novo componente à área central
  void call(
      {required Component component, required ComponentList componentList}) {
    componentList.addComponent(component);
  }
}
