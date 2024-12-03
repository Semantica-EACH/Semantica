import 'package:semantica/features/component/domain/entities/component.dart';

abstract class ComponentState {}

class ComponentInitial extends ComponentState {}

class ComponentUpdated extends ComponentState {
  final List<Component> sidebarComponents;
  final Component? centralComponent;

  ComponentUpdated(this.sidebarComponents, this.centralComponent);
}
