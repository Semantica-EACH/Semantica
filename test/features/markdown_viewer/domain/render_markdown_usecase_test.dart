import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Importa corretamente o caso de uso e a interface original do repositório.
import 'package:semantica/features/markdown_viewer/domain/usecases/render_markdown.dart';
import 'package:semantica/features/markdown_viewer/domain/repositories/markdown_repository.dart';

// Classe mock para simular o comportamento do repositório.
class MockMarkdownRepository extends Mock implements MarkdownRepository {}

void main() {
  late MockMarkdownRepository mockRepository;
  late RenderMarkdown renderMarkdown;

  setUp(() {
    mockRepository = MockMarkdownRepository();
    renderMarkdown = RenderMarkdown(mockRepository);
  });

  test('Deve retornar um objeto MarkdownContent com o conteúdo correto',
      () async {
    // Simula o comportamento do repositório.
    when(() => mockRepository.fetchMarkdown())
        .thenAnswer((_) async => '# Título\nConteúdo');

    // Executa o caso de uso.
    final result = await renderMarkdown();

    // Valida o resultado.
    expect(result.content, '# Título\nConteúdo');
  });
}
