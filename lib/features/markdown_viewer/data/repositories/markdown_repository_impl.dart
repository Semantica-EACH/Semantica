import '../../domain/repositories/markdown_repository.dart';
import '../datasources/markdown_local_datasource.dart';

class MarkdownRepositoryImpl implements MarkdownRepository {
  final MarkdownLocalDataSource localDataSource;

  MarkdownRepositoryImpl(this.localDataSource);

  @override
  Future<String> fetchMarkdown() async {
    try {
      return await localDataSource.readMarkdownFile('caminho_do_arquivo.md');
    } catch (e) {
      throw Exception('Erro ao carregar o arquivo Markdown: $e');
    }
  }
}
