import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';

class MockComponentView extends Mock implements ComponentView {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class TestComponentView extends MockComponentView {}

void main() {
  group('MockComponentView', () {
    test('should return correct string representation', () {
      final mockView = MockComponentView();
      expect(mockView.toString(), isNotNull);
    });
  });

  group('TestComponentView', () {
    test('should be an instance of MockComponentView', () {
      final testView = TestComponentView();
      expect(testView, isA<MockComponentView>());
    });
  });
}
