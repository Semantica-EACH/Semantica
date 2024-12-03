import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component_list/domain/entities/component_list.dart';

class CentralStack implements ComponentList {
  final List<Component> _components;
  int _currentIndex = -1;

  CentralStack([List<Component>? initialComponents])
      : _components = initialComponents ?? [];

  List<Component> get components => List.unmodifiable(_components);
  int get currentIndex => _currentIndex;

  Component? get currentComponent =>
      _currentIndex >= 0 && _currentIndex < _components.length
          ? _components[_currentIndex]
          : null;

  @override
  void addComponent(Component component) {
    if (_currentIndex >= 0 && _currentIndex < _components.length - 1) {
      // Descartar todos os componentes após o currentComponent
      _components.removeRange(_currentIndex + 1, _components.length);
    }
    // Adicionar o novo componente ao final da lista
    _components.add(component);
    _currentIndex = _components.length - 1;
  }

  @override
  void removeComponent(Component component) {
    int index = _components.indexOf(component);
    if (index != -1) {
      _components.removeAt(index);
      if (_currentIndex >= index) {
        _currentIndex = _currentIndex > 0 ? _currentIndex - 1 : -1;
      }
    }
  }

  void navigateToPrevious() {
    if (_currentIndex > 0) {
      _currentIndex--;
    }
  }

  void navigateToNext() {
    if (_currentIndex < _components.length - 1) {
      _currentIndex++;
    }
  }

  void clear() {
    _components.clear();
    _currentIndex = -1;
  }

  Component? getCurrentComponent() {
    return currentComponent;
  }
}