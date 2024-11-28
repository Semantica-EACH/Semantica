import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/usecases/enable_editing_usecase.dart';

void main() {
  group('EnableEditingUseCase', () {
    test('should set isEditing to true', () {
      // Arrange
      final page = Page(
        path: '/test',
        title: 'Test Page',
        timestamp: DateTime.now(),
        metadata: [],
        content: '',
      );
      final useCase = EnableEditingUseCase();

      // Act
      useCase(page);

      // Assert
      expect(page.isEditing, isTrue);
    });
  });
}
