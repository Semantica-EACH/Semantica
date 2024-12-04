import 'package:semantica/features/component/domain/entities/component.dart';

abstract class NavigationState {}

class NavigationInitial extends NavigationState {}

class NavigationUpdated extends NavigationState {
  final Component? currentComponent;

  NavigationUpdated(this.currentComponent);
}
