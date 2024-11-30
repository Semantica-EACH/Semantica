import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// Visualizador de Markdown reutilizável
class MarkdownViewer extends StatelessWidget {
  final String markdownContent;

  const MarkdownViewer({
    super.key,
    required this.markdownContent,
  });

  @override
  Widget build(BuildContext context) {
    print('Renderizando Markdown: $markdownContent');

    return Markdown(
      data: markdownContent,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
    );
  }
}
