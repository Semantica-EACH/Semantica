import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/usecases/save_page_usecase.dart';
import 'package:semantica/features/pages/presentation/cubit/page_cubit.dart';
import 'package:semantica/features/pages/presentation/cubit/page_cubit_states.dart';

class MockSavePageContentUseCase extends Mock
    implements SavePageContentUseCase {}

class FakePage extends Fake implements Page {}

void main() {
  late PageCubit pageCubit;
  late MockSavePageContentUseCase mockSavePageContentUseCase;
  late Page testPage;

  setUpAll(() {
    registerFallbackValue(FakePage());
  });

  setUp(() {
    mockSavePageContentUseCase = MockSavePageContentUseCase();
    testPage = Page(
      path: 'test.md',
      title: 'Test Page',
      content: '# Test Content',
      timestamp: DateTime.now(),
      metadata: [],
    );
    pageCubit = PageCubit(
      page: testPage,
      savePageContentUseCase: mockSavePageContentUseCase,
    );
  });

  group('PageCubit', () {
    test('initial state is PageViewing', () {
      expect(pageCubit.state, isA<PageViewing>());
    });

    blocTest<PageCubit, PageState>(
      'emits [PageEditing] when enterEditMode is called',
      build: () => pageCubit,
      act: (cubit) => cubit.enterEditMode(),
      expect: () => [isA<PageEditing>()],
    );

    blocTest<PageCubit, PageState>(
      'emits [PageViewing] after exitEditMode is called',
      build: () => pageCubit,
      setUp: () {
        when(() => mockSavePageContentUseCase.call(any()))
            .thenAnswer((_) async {});
      },
      act: (cubit) => cubit.exitEditMode('# Updated Content'),
      verify: (_) {
        expect(testPage.content, equals('# Updated Content'));
        verify(() => mockSavePageContentUseCase.call(testPage)).called(1);
      },
      expect: () => [isA<PageViewing>()],
    );

    blocTest<PageCubit, PageState>(
      'emits [PageViewing] when returnToViewing is called',
      build: () => pageCubit,
      act: (cubit) => cubit.returnToViewing(),
      expect: () => [isA<PageViewing>()],
    );

    blocTest<PageCubit, PageState>(
      'throws an exception when savePageContentUseCase fails during exitEditMode',
      build: () => pageCubit,
      setUp: () {
        when(() => mockSavePageContentUseCase.call(any()))
            .thenThrow(Exception('Erro ao salvar a página'));
      },
      act: (cubit) => cubit.exitEditMode('# Updated Content'),
      errors: () => [isA<Exception>()],
    );
  });
}
