import '../entities/markdown_content.dart';
import '../repositories/markdown_repository.dart';

class RenderMarkdown {
  final MarkdownRepository repository;

  // Injeta o repositório ao criar o caso de uso.
  RenderMarkdown(this.repository);

  // Método principal para buscar e processar o conteúdo Markdown.
  Future<MarkdownContent> call() async {
    final markdownString = await repository.fetchMarkdown();

    // Cria a entidade MarkdownContent com o conteúdo.
    return MarkdownContent(content: markdownString);
  }
}
