import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component_list/domain/entities/component_list.dart';

class CloseComponentUseCase {
  /// Remove o componente da lista fornecida
  void call(
      {required Component component, required ComponentList componentList}) {
    componentList.removeComponent(component);
  }
}
