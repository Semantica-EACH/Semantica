import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/core/markdown/markdown_viewer.dart';

void main() {
  group('MarkdownViewer', () {
    testWidgets('renders provided markdown content', (tester) async {
      const markdownContent = '# Test Header\nThis is a test paragraph.';

      await tester.pumpWidget(
        const MaterialApp(
          home: MarkdownViewer(markdownContent: markdownContent),
        ),
      );

      // Verifica se o cabeçalho do Markdown é renderizado
      expect(find.text('Test Header'), findsOneWidget);

      // Verifica se o parágrafo do Markdown é renderizado
      expect(find.text('This is a test paragraph.'), findsOneWidget);
    });

    testWidgets('applies custom MarkdownStyleSheet correctly', (tester) async {
      const markdownContent = '**Bold Text**';

      // Define um estilo personalizado
      final customStyle = MarkdownStyleSheet(
        p: const TextStyle(color: Colors.red),
        strong: const TextStyle(color: Colors.blue),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Markdown(
              data: markdownContent,
              styleSheet: customStyle,
            ),
          ),
        ),
      );

      // Localiza o widget Markdown
      final markdownFinder = find.byType(Markdown);
      expect(markdownFinder, findsOneWidget);

      // Recupera o widget para verificar o estilo aplicado
      final markdownWidget = tester.widget<Markdown>(markdownFinder);

      expect(markdownWidget.styleSheet!.p!.color, equals(Colors.red));
      expect(markdownWidget.styleSheet!.strong!.color, equals(Colors.blue));
    });
  });
}
