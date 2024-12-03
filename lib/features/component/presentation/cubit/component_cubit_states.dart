import 'package:semantica/features/component_list/domain/entities/central_stack.dart';
import 'package:semantica/features/component_list/domain/entities/side_list.dart';

abstract class ComponentState {}

class ComponentInitial extends ComponentState {}

class ComponentUpdated extends ComponentState {
  final SideList sideList;
  final CentralStack centralStack;

  ComponentUpdated({required this.sideList, required this.centralStack});
}
