import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/usecases/disable_editing_usecase.dart';
import 'package:semantica/features/pages/domain/usecases/enable_editing_usecase.dart';
import 'package:semantica/features/pages/presentation/state/page_state.dart';

void main() {
  group('PageState', () {
    late Page page;
    late EnableEditingUseCase enableEditing;
    late DisableEditingUseCase disableEditing;
    late PageState pageState;

    setUp(() {
      page = Page(
        path: '/test',
        title: 'Test Page',
        timestamp: DateTime.now(),
        metadata: [],
        content: '',
      );
      enableEditing = EnableEditingUseCase();
      disableEditing = DisableEditingUseCase();
      pageState = PageState(
        page: page,
        enableEditing: enableEditing,
        disableEditing: disableEditing,
      );
    });

    test('should toggle editing state from false to true', () {
      // Act
      pageState.toggleEditing();

      // Assert
      expect(page.isEditing, isTrue);
    });

    test('should toggle editing state from true to false', () {
      // Arrange
      page.isEditing = true;

      // Act
      pageState.toggleEditing();

      // Assert
      expect(page.isEditing, isFalse);
    });

    test('should notify listeners when state changes', () {
      // Arrange
      bool notified = false;
      pageState.addListener(() {
        notified = true;
      });

      // Act
      pageState.toggleEditing();

      // Assert
      expect(notified, isTrue);
    });
  });
}
