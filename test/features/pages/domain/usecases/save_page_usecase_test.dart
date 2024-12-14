import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/repository/page_repository.dart';
import 'package:semantica/features/pages/domain/usecases/save_page_usecase.dart';

class MockPageRepository extends Mock implements PageRepository {}

void main() {
  late SavePageContentUseCase savePageContentUseCase;
  late MockPageRepository mockRepository;

  setUp(() {
    mockRepository = MockPageRepository();
    savePageContentUseCase = SavePageContentUseCase(repository: mockRepository);
  });

  group('SavePageContentUseCase', () {
    const filePath = 'test.md';
    const fileContent = '# Test Content';

    final testPage = Page(
      path: filePath,
      title: 'Test Page',
      content: Block.root(fileContent),
      timestamp: DateTime(2023, 1, 1),
      metadata: [],
    );

    test('should call repository.savePageContent with correct Page', () async {
      // Configura o mock para não lançar exceções
      when(() => mockRepository.savePageContent(testPage))
          .thenAnswer((_) async {});

      // Chama o caso de uso
      await savePageContentUseCase.call(testPage);

      // Verifica se o método foi chamado corretamente
      verify(() => mockRepository.savePageContent(testPage)).called(1);
    });

    test('should throw an exception when repository.savePageContent fails',
        () async {
      // Configura o mock para lançar uma exceção
      when(() => mockRepository.savePageContent(testPage))
          .thenThrow(Exception('Erro ao salvar a página'));

      // Verifica se o caso de uso lança a exceção
      expect(
        () async => await savePageContentUseCase.call(testPage),
        throwsException,
      );

      // Verifica se o método foi chamado
      verify(() => mockRepository.savePageContent(testPage)).called(1);
    });
  });
}
