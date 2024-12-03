import 'package:bloc/bloc.dart';
import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component/domain/usecases/close_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/maximize_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/minimize_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/open_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/redo_usecase.dart';
import 'package:semantica/features/component/domain/usecases/undo_usecase.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';
import 'package:semantica/features/component_list/domain/entities/central_stack.dart';
import 'package:semantica/features/component_list/domain/entities/side_list.dart';

class ComponentCubit extends Cubit<ComponentState> {
  final MaximizeComponentUseCase maximizeUseCase;
  final MinimizeComponentUseCase minimizeUseCase;
  final CloseComponentUseCase closeUseCase;
  final OpenComponentUseCase openComponentUseCase;
  final UndoUseCase undoUseCase;
  final RedoUseCase redoUseCase;

  final SideList sideList;
  final CentralStack centralStack;

  ComponentCubit({
    required this.maximizeUseCase,
    required this.minimizeUseCase,
    required this.openComponentUseCase,
    required this.closeUseCase,
    required this.sideList,
    required this.centralStack,
    required this.undoUseCase,
    required this.redoUseCase,
  }) : super(ComponentInitial());

  void openComponent(Component component) {
    openComponentUseCase.call(
        component: component, componentList: centralStack);
    emit(ComponentUpdated(sideList: sideList, centralStack: centralStack));
  }

  void maximizeComponent(Component component) {
    maximizeUseCase.call(
        component: component, sideList: sideList, centralStack: centralStack);
    emit(ComponentUpdated(
      sideList: sideList,
      centralStack: centralStack,
    ));
  }

  void minimizeComponent(Component component) {
    minimizeUseCase.call(
        component: component, sideList: sideList, centralStack: centralStack);
    emit(ComponentUpdated(
      sideList: sideList,
      centralStack: centralStack,
    ));
  }

  void closeComponent(Component component) {
    closeUseCase.call(component: component, componentList: sideList);
    closeUseCase.call(component: component, componentList: centralStack);
    emit(ComponentUpdated(
      sideList: sideList,
      centralStack: centralStack,
    ));
  }

  void undo() {
    undoUseCase.call(centralStack);
    emit(ComponentUpdated(sideList: sideList, centralStack: centralStack));
  }

  void redo() {
    centralStack.navigateToNext();
    emit(ComponentUpdated(sideList: sideList, centralStack: centralStack));
  }

  bool isFirst() => centralStack.isFirst();
  bool isLast() => centralStack.isLast();
}
