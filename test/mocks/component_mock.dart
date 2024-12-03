import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';

import 'component_view_mock.dart';

class TestComponent extends Component {
  TestComponent({required super.title});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TestComponent && other.title == title;
  }

  @override
  int get hashCode => title.hashCode;

  @override
  ComponentView toComponentView() {
    return MockComponentView();
  }
}

class MockComponent extends Mock implements Component {}

void main() {
  group('Component Mock Tests', () {
    late MockComponent mockComponent;

    setUp(() {
      mockComponent = MockComponent();
    });

    test('should correctly assign title', () {
      const title = 'Test Title';
      final component = TestComponent(title: title);

      expect(component.title, equals(title));
    });

    test('should mock Component title', () {
      const title = 'Mock Title';

      when(() => mockComponent.title).thenReturn(title);

      expect(mockComponent.title, equals(title));
      verify(() => mockComponent.title).called(1);
    });

    test('should verify no interactions with mock', () {
      verifyNever(() => mockComponent.title);
    });

    test('should throw when accessing unmocked property', () {
      when(() => mockComponent.title).thenThrow(UnimplementedError());

      expect(() => mockComponent.title, throwsA(isA<UnimplementedError>()));
    });
  });
}
