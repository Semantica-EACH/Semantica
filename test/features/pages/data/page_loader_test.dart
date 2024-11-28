import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/features/pages/data/page_loader.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';

// Mock para a classe File
class MockFile extends Mock implements File {}

void main() {
  group('PageLoader', () {
    late MockFile mockFile;
    late PageLoader pageLoader;

    setUp(() {
      mockFile = MockFile();
      pageLoader = PageLoader(fileFactory: (_) => mockFile);
    });

    test('deve carregar uma página corretamente quando o arquivo existe',
        () async {
      // Arrange
      const path = '/test/file.md';
      const content = 'Este é o conteúdo do arquivo.';
      const title = 'file';
      final timestamp = DateTime(2023, 1, 1);

      when(() => mockFile.exists()).thenAnswer((_) async => true);
      when(() => mockFile.readAsString()).thenAnswer((_) async => content);
      when(() => mockFile.lastModified()).thenAnswer((_) async => timestamp);
      when(() => mockFile.path).thenReturn(path);

      // Act
      final result = await pageLoader.loadPage(path);

      // Assert
      expect(result, isA<Page>());
      expect(result.path, path);
      expect(result.title, title);
      expect(result.timestamp, timestamp);
      expect(result.content, content);
    });

    test('deve lançar uma exceção se o arquivo não existir', () async {
      // Arrange
      const path = '/test/nonexistent.md';
      when(() => mockFile.exists()).thenAnswer((_) async => false);

      // Act & Assert
      expect(
        () => pageLoader.loadPage(path),
        throwsA(isA<Exception>()),
      );
    });

    test('deve lançar uma exceção se ocorrer um erro ao ler o arquivo',
        () async {
      // Arrange
      const path = '/test/file.md';
      when(() => mockFile.exists()).thenAnswer((_) async => true);
      when(() => mockFile.readAsString())
          .thenThrow(const FileSystemException('Erro ao ler o arquivo'));

      // Act & Assert
      expect(
        () => pageLoader.loadPage(path),
        throwsA(isA<Exception>()),
      );
    });
  });
}
