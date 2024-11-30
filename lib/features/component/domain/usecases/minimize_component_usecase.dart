import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';

class MinimizeComponentUseCase {
  /// Atualiza os estados dos componentes para minimizar o central
  Map<String, dynamic> call(String title, ComponentView? centralComponent,
      List<ComponentView> sidebarComponents) {
    if (centralComponent == null) {
      throw Exception("Nenhum componente central para minimizar");
    }

    final updatedSidebarComponents = List<ComponentView>.from(sidebarComponents)
      ..add(centralComponent);

    return {
      'sidebarComponents': updatedSidebarComponents,
      'centralComponent': null,
    };
  }
}
