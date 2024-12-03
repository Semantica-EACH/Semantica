import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/core/markdown/markdown_editor.dart';
import 'package:semantica/core/markdown/markdown_viewer.dart';
import 'package:semantica/features/pages/domain/entities/page.dart' as my_page;
import 'package:semantica/features/pages/domain/usecases/save_page_usecase.dart';

class MockSavePageContentUseCase extends Mock
    implements SavePageContentUseCase {}

class FakePage extends Fake implements my_page.Page {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakePage());
  });

  setUp(() {});

  group('PageWidget', () {
    testWidgets('renders MarkdownViewer in viewing mode', (tester) async {
      const markdownContent = '# Test Content';

      await tester.pumpWidget(
        const MaterialApp(
          home: MarkdownViewer(markdownContent: markdownContent),
        ),
      );

      // Localiza o elemento renderizado pelo Markdown (o cabeçalho H1)
      final markdownHeaderFinder = find.text('Test Content');

      // Verifica se o cabeçalho foi renderizado
      expect(markdownHeaderFinder, findsOneWidget);
    });

    testWidgets('renders MarkdownEditor correctly', (tester) async {
      const initialContent = '# Test Content';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            // Adiciona Scaffold para fornecer um Material context
            body: MarkdownEditor(
              initialContent: initialContent,
              onContentChanged: (_) {},
            ),
          ),
        ),
      );

      // Verifica se o conteúdo inicial está no TextField
      final textFieldFinder = find.byType(TextField);
      expect(textFieldFinder, findsOneWidget);
      expect(find.text('# Test Content'), findsOneWidget);
    });

    testWidgets(
      'calls exitEditMode and saves content when focus is lost',
      (tester) async {
        fail('Este teste deve ser implementado no futuro.');
      },
    );

/*    testWidgets('renders Sidebar correctly', (tester) async {
      final sidebarWidget = PageWidget(
        page: testPage,
        savePageContentUseCase: mockSavePageContentUseCase,
      ).renderSidebar(tester.element(find.byType(MaterialApp)));

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: sidebarWidget,
          ),
        ),
      );

      // Verifica se o ListTile do sidebar é renderizado corretamente
      expect(find.text('Test Page'), findsOneWidget);
      expect(find.text('Última modificação: ${testPage.timestamp}'),
          findsOneWidget);
    });*/
  });
}
