import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component_list/domain/entities/component_list.dart';

class MockComponent extends Mock implements Component {}

class TestComponentList extends ComponentList {
  final List<Component> _components = [];

  @override
  void addComponent(Component component) {
    _components.add(component);
  }

  @override
  void removeComponent(Component component) {
    _components.remove(component);
  }

  List<Component> get components => _components;
}

void main() {
  late TestComponentList componentList;
  late MockComponent mockComponent;

  setUp(() {
    componentList = TestComponentList();
    mockComponent = MockComponent();
  });

  test('should add a component to the list', () {
    // Act
    componentList.addComponent(mockComponent);

    // Assert
    expect(componentList.components, contains(mockComponent));
  });

  test('should remove a component from the list', () {
    // Arrange
    componentList.addComponent(mockComponent);

    // Act
    componentList.removeComponent(mockComponent);

    // Assert
    expect(componentList.components, isNot(contains(mockComponent)));
  });
}
