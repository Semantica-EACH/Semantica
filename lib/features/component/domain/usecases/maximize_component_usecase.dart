import 'package:semantica/features/component/presentation/widgets/component_view.dart';

class MaximizeComponentUseCase {
  /// Atualiza os estados dos componentes para maximizar um
  Map<String, dynamic> call(String title, List<ComponentView> sidebarComponents,
      ComponentView? centralComponent) {
    final updatedSidebarComponents = List<ComponentView>.from(sidebarComponents)
      ..removeWhere((component) => component.component.title == title);

    final maximizedComponent = sidebarComponents.firstWhere(
      (component) => component.component.title == title,
      orElse: () =>
          throw Exception("Componente não encontrado na barra lateral"),
    );

    return {
      'sidebarComponents': updatedSidebarComponents,
      'centralComponent': maximizedComponent,
    };
  }
}
