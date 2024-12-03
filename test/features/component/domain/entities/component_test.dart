// FILE: lib/features/component/domain/entities/component_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';

import '../../../../mocks/component_view_mock.dart';

class TestComponent extends Component {
  TestComponent({required super.title});

  @override
  ComponentView toComponentView() {
    return MockComponentView();
  }
}

void main() {
  group('Component', () {
    test('should correctly assign title', () {
      const title = 'Test Title';
      final component = TestComponent(title: title);

      expect(component.title, equals(title));
    });
  });
}
