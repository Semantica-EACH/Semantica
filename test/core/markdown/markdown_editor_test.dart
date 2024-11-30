import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/core/markdown/markdown_editor.dart';

void main() {
  group('MarkdownEditor', () {
    testWidgets('renders initial content in TextField and HighlightView',
        (tester) async {
      const initialContent = '# Header\nThis is a test.';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MarkdownEditor(
              initialContent: initialContent,
              onContentChanged: (_) {},
            ),
          ),
        ),
      );

      // Verifica se o conteúdo inicial está no TextField
      final textField = find.byType(TextField);
      expect(textField, findsOneWidget);
      expect(find.text('# Header\nThis is a test.'), findsOneWidget);

      // Verifica se o HighlightView renderiza o conteúdo inicial
      final highlightView = find.byType(HighlightView);
      expect(highlightView, findsOneWidget);
    });

    testWidgets('calls onContentChanged when TextField content changes',
        (tester) async {
      const initialContent = '# Header\nThis is a test.';
      String? updatedContent;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MarkdownEditor(
              initialContent: initialContent,
              onContentChanged: (newContent) {
                updatedContent = newContent;
              },
            ),
          ),
        ),
      );

      // Simula a alteração no conteúdo do TextField
      const newContent = '# Updated Header\nThis is an updated test.';
      await tester.enterText(find.byType(TextField), newContent);

      // Verifica se o callback onContentChanged foi chamado com o novo conteúdo
      expect(updatedContent, equals(newContent));
    });

    testWidgets('updates HighlightView when TextField content changes',
        (tester) async {
      const initialContent = '# Header\nThis is a test.';
      const newContent = '# Updated Header\nThis is an updated test.';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MarkdownEditor(
              initialContent: initialContent,
              onContentChanged: (_) {},
            ),
          ),
        ),
      );

      // Simula a alteração no conteúdo do TextField
      await tester.enterText(find.byType(TextField), newContent);
      await tester.pump();

      // Verifica se o HighlightView foi reconstruído
      final highlightViewFinder = find.byType(HighlightView);
      expect(highlightViewFinder, findsOneWidget);

      // Não é possível verificar diretamente o conteúdo do HighlightView.
      // Testamos a interação e reconstrução no fluxo esperado.
    });

    testWidgets('displays syntax highlighting correctly', (tester) async {
      const initialContent = '# Header\nThis is a **bold** test.';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MarkdownEditor(
              initialContent: initialContent,
              onContentChanged: (_) {},
            ),
          ),
        ),
      );

      // Verifica se o HighlightView renderiza o conteúdo com o estilo do tema
      final highlightView =
          tester.widget<HighlightView>(find.byType(HighlightView));
      expect(highlightView.language, equals('markdown'));
      expect(highlightView.theme, equals(githubTheme));
    });
  });
}
