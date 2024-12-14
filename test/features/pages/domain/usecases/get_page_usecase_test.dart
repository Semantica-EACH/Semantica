import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/repository/page_repository.dart';
import 'package:semantica/features/pages/domain/usecases/get_page_usecase.dart';

class MockPageRepository extends Mock implements PageRepository {}

void main() {
  late GetPageUseCase getPageUseCase;
  late MockPageRepository mockRepository;

  setUp(() {
    mockRepository = MockPageRepository();
    getPageUseCase = GetPageUseCase(repository: mockRepository);
  });

  group('GetPageUseCase', () {
    const filePath = 'test.md';
    final testPage = Page(
      path: filePath,
      title: 'Test Page',
      content: Block.root('# Test Content'),
      timestamp: DateTime(2023, 1, 1),
      metadata: [],
    );

    test('should return a Page when repository.getPage succeeds', () async {
      // Configura o mock para retornar uma página
      when(() => mockRepository.getPage(filePath))
          .thenAnswer((_) async => testPage);

      // Chama o caso de uso
      final page = await getPageUseCase.call(filePath);

      // Verifica o resultado
      expect(page, equals(testPage));

      // Verifica se o método foi chamado corretamente
      verify(() => mockRepository.getPage(filePath)).called(1);
    });

    test('should throw an exception when repository.getPage fails', () async {
      // Configura o mock para lançar uma exceção
      when(() => mockRepository.getPage(filePath))
          .thenThrow(Exception('Erro ao carregar a página'));

      // Verifica se o caso de uso lança a exceção
      expect(
        () async => await getPageUseCase.call(filePath),
        throwsException,
      );

      // Verifica se o método foi chamado
      verify(() => mockRepository.getPage(filePath)).called(1);
    });
  });
}
