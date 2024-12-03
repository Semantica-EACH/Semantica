import 'package:bloc/bloc.dart';
import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component/domain/usecases/close_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/maximize_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/minimize_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/open_component_usecase.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';
import 'package:semantica/features/component_list/domain/entities/central_stack.dart';
import 'package:semantica/features/component_list/domain/entities/side_list.dart';

class ComponentCubit extends Cubit<ComponentState> {
  final MaximizeComponentUseCase maximizeUseCase;
  final MinimizeComponentUseCase minimizeUseCase;
  final CloseComponentUseCase closeUseCase;
  final OpenComponentUseCase openComponentUseCase;

  final SideList sideList;
  final CentralStack centralStack;

  ComponentCubit({
    required this.maximizeUseCase,
    required this.minimizeUseCase,
    required this.openComponentUseCase,
    required this.closeUseCase,
    required this.sideList,
    required this.centralStack,
  }) : super(ComponentInitial());

  void openComponent(Component component) {
    openComponentUseCase.call(component: component, centralStack: centralStack);
    emit(ComponentUpdated(sideList.components, centralStack.currentComponent));
  }

  void maximizeComponent(Component component) {
    maximizeUseCase.call(
        component: component, sideList: sideList, centralStack: centralStack);
    emit(ComponentUpdated(
      sideList.components,
      centralStack.currentComponent,
    ));
  }

  void minimizeComponent(Component component) {
    minimizeUseCase.call(
        component: component, sideList: sideList, centralStack: centralStack);
    emit(ComponentUpdated(
      sideList.components,
      centralStack.currentComponent,
    ));
  }

  void closeComponent(Component component) {
    closeUseCase.call(component: component, componentList: sideList);
    closeUseCase.call(component: component, componentList: centralStack);
    emit(ComponentUpdated(
      sideList.components,
      centralStack.currentComponent,
    ));
  }
}
