import 'package:semantica/features/component/presentation/widgets/component_view.dart';

class CloseComponentUseCase {
  /// Atualiza os estados dos componentes para fechar um
  Map<String, dynamic> call(String title, List<ComponentView> sidebarComponents,
      ComponentView? centralComponent) {
    final updatedSidebarComponents = List<ComponentView>.from(sidebarComponents)
      ..removeWhere((component) => component.component.title == title);

    final updatedCentralComponent =
        (centralComponent?.component.title == title) ? null : centralComponent;

    return {
      'sidebarComponents': updatedSidebarComponents,
      'centralComponent': updatedCentralComponent,
    };
  }
}
