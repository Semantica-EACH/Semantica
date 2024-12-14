import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/pages/domain/entities/page.dart' as my_page;
import 'package:semantica/features/pages/domain/usecases/save_page_usecase.dart';
import 'package:semantica/features/pages/presentation/cubit/page_cubit.dart';

class MockSavePageContentUseCase extends Mock
    implements SavePageContentUseCase {}

class MockPage extends Mock implements my_page.Page {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late PageCubit pageCubit;
  late MockSavePageContentUseCase mockSavePageContentUseCase;
  late MockPage mockPage;
  late MockBuildContext mockBuildContext;

  setUpAll(() {
    registerFallbackValue(MockPage());
  });

  setUp(() {
    mockBuildContext = MockBuildContext();
    mockSavePageContentUseCase = MockSavePageContentUseCase();
    mockPage = MockPage();
    when(() => mockPage.path).thenReturn('test.md');
    when(() => mockPage.title).thenReturn('Test Page');
    when(() => mockPage.content)
        .thenReturn(Block.fromMarkdown('# Test Content'));
    when(() => mockPage.timestamp).thenReturn(DateTime.now());
    when(() => mockPage.metadata).thenReturn([]);
    when(() => mockSavePageContentUseCase.call(any()))
        .thenAnswer((_) async => {});

    pageCubit = PageCubit(
      mockBuildContext,
      page: mockPage,
      savePageContentUseCase: mockSavePageContentUseCase,
    );
  });

  group('PageCubit', () {
    blocTest<PageCubit, void>(
      'calls savePageContentUseCase when savePage is called',
      build: () => pageCubit,
      act: (cubit) => cubit.savePage(mockPage.content.toMarkdown()),
      verify: (_) {
        verify(() => mockSavePageContentUseCase(any())).called(1);
      },
    );
  });
}
