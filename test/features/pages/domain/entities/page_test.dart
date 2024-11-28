import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:test/test.dart';

void main() {
  group('Page', () {
    test('render should return a valid map representation of the Page', () {
      // Arrange
      final page = Page(
        path: '/home/test-page',
        title: 'Test Page',
        timestamp: DateTime(2024, 1, 1, 12, 0),
        metadata: ['tag1', 'tag2'],
        content: 'This is the content of the page.',
      );

      // Act
      final rendered = page.render();

      // Assert
      expect(rendered, {
        'path': '/home/test-page',
        'name': 'Test Page',
        'type': 'Page',
        'title': 'Test Page',
        'timestamp': '2024-01-01T12:00:00.000',
        'metadata': ['tag1', 'tag2'],
        'content': 'This is the content of the page.',
        'isEditing': false, // Adicionado para refletir o novo campo
      });
    });
  });
}
