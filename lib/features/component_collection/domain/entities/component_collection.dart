import 'package:semantica/features/component/domain/entities/component.dart';

abstract class ComponentCollection {
  void addComponent(Component component);
  void removeComponent(Component component);
}
