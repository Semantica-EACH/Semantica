import 'dart:io';
import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/presentation/widgets/page_widget.dart';
import 'package:test/test.dart';

void main() {
  group('Page', () {
    test('render should return a PageWidget with correct page data', () {
      // Arrange
      final page = Page(
        path: '/home/test-page',
        title: 'Test Page',
        timestamp: DateTime(2024, 1, 1, 12, 0),
        metadata: ['tag1', 'tag2'],
        content: 'This is the content of the page.',
      );

      // Act
      final widget = page.render();

      // Assert
      expect(widget, isA<PageWidget>()); // Verifica se é um PageWidget
      final pageWidget = widget as PageWidget;
      expect(pageWidget.page,
          equals(page)); // Verifica se o PageWidget contém a página correta
    });
  });

  group('Page.saveContent', () {
    test('Deve salvar o conteúdo em um arquivo', () async {
      // Arrange: Configura uma página com conteúdo
      final tempDir = Directory.systemTemp.createTempSync();
      final filePath = '${tempDir.path}/test.md';
      final page = Page(
        path: filePath,
        title: 'Teste',
        timestamp: DateTime.now(),
        metadata: [],
        content: 'Conteúdo inicial',
      );

      // Act: Chama o método saveContent
      page.saveContent();

      // Assert: Verifica se o conteúdo foi salvo no arquivo
      final file = File(filePath);
      expect(file.existsSync(), isTrue);
      final savedContent = file.readAsStringSync();
      expect(savedContent, equals('Conteúdo inicial'));

      // Cleanup: Remove o arquivo e diretório temporário
      tempDir.deleteSync(recursive: true);
    });
  });
}
