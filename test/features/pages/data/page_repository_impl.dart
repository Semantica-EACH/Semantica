import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/pages/data/page_loader.dart';
import 'package:semantica/features/pages/data/page_repository_impl.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';

class MockFile extends Mock implements File {}

class MockPageLoader extends Mock implements PageLoader {}

void main() {
  late PageRepositoryImpl repository;
  late MockFile mockFile;
  late MockPageLoader mockPageLoader;

  setUp(() {
    mockPageLoader = MockPageLoader();
    repository = PageRepositoryImpl(pageLoader: mockPageLoader);
    mockFile = MockFile();
  });

  group('PageRepositoryImpl', () {
    test('should save page content correctly', () async {
      const filePath = 'test.md';
      const fileContent = '# Test Content';

      // Mocka o comportamento do File
      when(() => mockFile.writeAsString(any()))
          .thenAnswer((_) async => mockFile);

      // Cria uma instância de Page
      final page = Page(
        path: filePath,
        title: 'Test Page',
        content: Block.root(fileContent),
        timestamp: DateTime.now(),
        metadata: [],
      );

      // Salva o conteúdo usando o repositório
      await repository.savePageContent(page);

      // Verifica se o método writeAsString foi chamado corretamente
      verify(() => mockFile.writeAsString(page.content.toMarkdown())).called(1);
    });

    test('should throw an exception if saving fails', () async {
      const filePath = 'test.md';
      const fileContent = '# Test Content';

      // Mocka uma falha no writeAsString
      when(() => mockFile.writeAsString(fileContent))
          .thenThrow(Exception('Erro ao salvar o arquivo'));

      final page = Page(
        path: filePath,
        title: 'Test Page',
        content: Block.root(fileContent),
        timestamp: DateTime.now(),
        metadata: [],
      );

      expect(
        () async => await repository.savePageContent(page),
        throwsA(isA<Exception>()),
      );
    });

    test('should return a Page when loading succeeds', () async {
      const filePath = 'test.md';
      const fileContent = '# Test Content';
      final timestamp = DateTime(2023, 1, 1);

      // Mocka o comportamento do PageLoader
      when(() => mockPageLoader.loadPage(filePath))
          .thenAnswer((_) async => Page(
                path: filePath,
                title: 'Test Page',
                content: Block.root(fileContent),
                timestamp: timestamp,
                metadata: [],
              ));

      // Chama o método getPage
      final page = await repository.getPage(filePath);

      expect(page, isA<Page>());
      expect(page.path, equals(filePath));
      expect(page.content, equals(fileContent));
      expect(page.timestamp, equals(timestamp));

      verify(() => mockPageLoader.loadPage(filePath)).called(1);
    });

    test('should throw an exception if loading fails', () async {
      const filePath = 'test.md';

      // Mocka uma falha no loadPage
      when(() => mockPageLoader.loadPage(filePath))
          .thenThrow(Exception('Erro ao carregar a página'));

      expect(
        () async => await repository.getPage(filePath),
        throwsException,
      );

      verify(() => mockPageLoader.loadPage(filePath)).called(1);
    });
  });
}
