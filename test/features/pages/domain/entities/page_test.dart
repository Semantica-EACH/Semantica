import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';

void main() {
  group('Page', () {
    const filePath = 'test.md';
    const fileTitle = 'Test Page';
    const fileContent = '# Test Content';
    final fileTimestamp = DateTime(2023, 1, 1);

    test('should correctly initialize with given values', () {
      final page = Page(
        path: filePath,
        title: fileTitle,
        timestamp: fileTimestamp,
        metadata: ['Tag1', 'Tag2'],
        content: fileContent,
      );

      expect(page.path, equals(filePath));
      expect(page.title, equals(fileTitle));
      expect(page.timestamp, equals(fileTimestamp));
      expect(page.metadata, equals(['Tag1', 'Tag2']));
      expect(page.content, equals(fileContent));
    });

    test('should allow updating title and content', () {
      final page = Page(
        path: filePath,
        title: fileTitle,
        timestamp: fileTimestamp,
        metadata: ['Tag1'],
        content: fileContent,
      );

      // Atualiza o título
      const updatedTitle = 'Updated Test Page';
      page.title = updatedTitle;
      expect(page.title, equals(updatedTitle));

      // Atualiza o conteúdo
      const updatedContent = '# Updated Content';
      page.content = updatedContent;
      expect(page.content, equals(updatedContent));
    });

    test('should allow modifying metadata', () {
      final page = Page(
        path: filePath,
        title: fileTitle,
        timestamp: fileTimestamp,
        metadata: ['Tag1'],
        content: fileContent,
      );

      // Adiciona um novo metadado
      page.metadata.add('Tag2');
      expect(page.metadata, equals(['Tag1', 'Tag2']));

      // Remove um metadado
      page.metadata.remove('Tag1');
      expect(page.metadata, equals(['Tag2']));
    });

    test('path should remain unchanged after initialization', () {
      final page = Page(
        path: filePath,
        title: fileTitle,
        timestamp: fileTimestamp,
        metadata: [],
        content: fileContent,
      );

      // Verifica que o valor do path permanece o mesmo
      expect(page.path, equals(filePath));
    });
  });
}
