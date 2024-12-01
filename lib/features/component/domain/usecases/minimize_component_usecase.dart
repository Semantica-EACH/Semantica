import 'package:semantica/features/component/presentation/widgets/component_view.dart';

class MinimizeComponentUseCase {
  /// Atualiza os estados dos componentes para minimizar o central
Map<String, dynamic> call(String title, ComponentView? centralComponent, List<ComponentView> sidebarComponents) {
  
  if (centralComponent != null && centralComponent.component.title == title) {
    return {
      'sidebarComponents': [...sidebarComponents, centralComponent],
      'centralComponent': null,
    };
  }

  return {
    'sidebarComponents': sidebarComponents,
    'centralComponent': centralComponent,
  };
}


}
