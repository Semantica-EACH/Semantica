import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/features/component/domain/usecases/close_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/maximize_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/minimize_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/open_component.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';
import 'component_cubit_states.dart';

class ComponentCubit extends Cubit<ComponentCubitState> {
  final MaximizeComponentUseCase maximizeUseCase;
  final MinimizeComponentUseCase minimizeUseCase;
  final CloseComponentUseCase closeUseCase;
  final OpenComponentUseCase openComponentUseCase;

  List<ComponentView> _sidebarComponents;
  ComponentView? _centralComponent;
  

  ComponentCubit({
    required List<ComponentView> initialSidebarComponents,
    required this.maximizeUseCase,
    required this.minimizeUseCase,
    required this.openComponentUseCase,
    required this.closeUseCase
  })  : _sidebarComponents = initialSidebarComponents,
        _centralComponent = null,
        super(ComponentInitial());

  void expandComponent(String title) {
    final updatedComponents = _sidebarComponents.map((component) {
      if (component.component.title == title) {
        component.isExpanded = !component.isExpanded;
      }
      return component;
    }).toList();

    emit(ComponentUpdated(updatedComponents, _centralComponent));
  }

  void open(ComponentView newComponent) {
    _centralComponent = newComponent; // Define o componente centralizado

    emit(ComponentOpened(_centralComponent)); // Emite o novo estado
  }


  void maximize(String title, [ComponentView? newComponent]) {
  final result = maximizeUseCase.call(
    title,
    _sidebarComponents,
    _centralComponent,
  );

  _sidebarComponents = result['sidebarComponents'];
  _centralComponent = result['centralComponent'];

  emit(ComponentUpdated(_sidebarComponents, _centralComponent));
}


  void minimize(String title) {
    final result =
        minimizeUseCase.call(title, _centralComponent, _sidebarComponents);

    _sidebarComponents = result['sidebarComponents'];
    _centralComponent = result['centralComponent'];

    emit(ComponentUpdated(_sidebarComponents, _centralComponent));
  }

  void closeComponent(String title) {
    final result =
        closeUseCase.call(title, _sidebarComponents, _centralComponent);

    _sidebarComponents = result['sidebarComponents'];
    _centralComponent = result['centralComponent'];

    emit(ComponentUpdated(_sidebarComponents, _centralComponent));
  }
}
