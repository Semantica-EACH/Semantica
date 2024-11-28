import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/usecases/disable_editing_usecase.dart';

void main() {
  group('DisableEditingUseCase', () {
    test('should set isEditing to false', () {
      // Arrange
      final page = Page(
        path: '/test',
        title: 'Test Page',
        timestamp: DateTime.now(),
        metadata: [],
        content: '',
        isEditing: true, // Inicialmente em modo de edição
      );
      final useCase = DisableEditingUseCase();

      // Act
      useCase(page);

      // Assert
      expect(page.isEditing, isFalse);
    });
  });
}
