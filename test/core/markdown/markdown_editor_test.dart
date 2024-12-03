import 'package:flutter/material.dart';
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
  });
}
