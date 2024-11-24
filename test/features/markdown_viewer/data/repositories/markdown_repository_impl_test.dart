import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:semantica/features/markdown_viewer/data/datasources/markdown_local_datasource.dart';
import 'package:semantica/features/markdown_viewer/data/repositories/markdown_repository_impl.dart';

class MockMarkdownLocalDataSource extends Mock
    implements MarkdownLocalDataSource {}

void main() {
  late MarkdownLocalDataSource mockLocalDataSource;
  late MarkdownRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockMarkdownLocalDataSource();
    repository = MarkdownRepositoryImpl(mockLocalDataSource);
  });

  test('Deve retornar o conteúdo do arquivo Markdown', () async {
    // Simula o comportamento da fonte de dados local.
    when(() => mockLocalDataSource.readMarkdownFile(any()))
        .thenAnswer((_) async => '# Título\nConteúdo do Markdown.');

    // Executa o repositório.
    final result = await repository.fetchMarkdown();

    // Valida o resultado.
    expect(result, '# Título\nConteúdo do Markdown.');
  });

  test('Deve lançar uma exceção se o arquivo não for encontrado', () async {
    // Simula um erro na leitura do arquivo.
    when(() => mockLocalDataSource.readMarkdownFile(any()))
        .thenThrow(Exception('Arquivo não encontrado'));

    // Executa o repositório e espera um erro.
    expect(() => repository.fetchMarkdown(), throwsException);
  });
}
