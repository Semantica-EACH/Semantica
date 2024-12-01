import 'package:semantica/features/component/presentation/widgets/component_view.dart';

class CloseComponentUseCase {
  /// Atualiza os estados dos componentes para fechar um
  Map<String, dynamic> call(String title, List<ComponentView> sidebarComponents, ComponentView? centralComponent) {
  // Remove o componente da barra lateral, se presente
  final updatedSidebarComponents = sidebarComponents.where((c) => c.component.title != title).toList();

  // Remove do componente central, se ele for o que está sendo fechado
  final isCentralComponent = centralComponent?.component.title == title;

  return {
    'sidebarComponents': updatedSidebarComponents,
    'centralComponent': isCentralComponent ? null : centralComponent,
  };
}

}
