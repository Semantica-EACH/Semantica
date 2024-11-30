import 'package:semantica/features/component/presentation/widgets/component_view.dart';

abstract class ComponentCubitState {}

class ComponentInitial extends ComponentCubitState {}

class ComponentUpdated extends ComponentCubitState {
  final List<ComponentView> sidebarComponents; // Componentes minimizados
  final ComponentView? centralComponent; // Componente maximizado (ou null)

  ComponentUpdated(this.sidebarComponents, this.centralComponent);
}
