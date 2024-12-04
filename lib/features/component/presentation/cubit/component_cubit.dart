import 'package:bloc/bloc.dart';
import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component/domain/usecases/history_manager.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';
import 'package:semantica/features/component_collection/domain/entities/central_stack.dart';
import 'package:semantica/features/component_collection/domain/entities/side_list.dart';
import 'package:semantica/features/component/domain/usecases/component_manager.dart';

class ComponentCubit extends Cubit<ComponentState> {
  final SideList sideList;
  final CentralStack centralStack;
  final ComponentManager componentManager;
  final HistoryManager historyManager;

  ComponentCubit({
    required this.sideList,
    required this.centralStack,
    required this.componentManager,
    required this.historyManager,
  }) : super(ComponentInitial());

  void openComponent(Component component) {
    componentManager.openComponent(
        component: component, componentCollection: centralStack);
    emit(ComponentUpdated(sideList: sideList, centralStack: centralStack));
  }

  void maximizeComponent(Component component) {
    componentManager.maximizeComponent(
        component: component, sideList: sideList, centralStack: centralStack);
    emit(ComponentUpdated(
      sideList: sideList,
      centralStack: centralStack,
    ));
  }

  void minimizeComponent(Component component) {
    componentManager.minimizeComponent(
        component: component, sideList: sideList, centralStack: centralStack);
    emit(ComponentUpdated(
      sideList: sideList,
      centralStack: centralStack,
    ));
  }

  void closeComponent(Component component) {
    componentManager.closeComponent(
        component: component, componentCollection: sideList);
    componentManager.closeComponent(
        component: component, componentCollection: centralStack);
    emit(ComponentUpdated(
      sideList: sideList,
      centralStack: centralStack,
    ));
  }

  void undo() {
    historyManager.undo(centralStack);
    emit(ComponentUpdated(sideList: sideList, centralStack: centralStack));
  }

  void redo() {
    historyManager.redo(centralStack);
    emit(ComponentUpdated(sideList: sideList, centralStack: centralStack));
  }

  bool isFirst() => centralStack.isFirst();
  bool isLast() => centralStack.isLast();
}
