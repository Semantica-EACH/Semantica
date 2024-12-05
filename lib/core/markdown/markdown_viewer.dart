import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:semantica/core/markdown/widgets/todo_element_builder.dart';

/// Visualizador de Markdown reutilizável
class MarkdownViewer extends StatelessWidget {
  final String markdownContent;

  const MarkdownViewer({
    super.key,
    required this.markdownContent,
  });

  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
      data: markdownContent,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
      builders: {
        'p': TodoElementBuilder(context: context),
        'li': TodoElementBuilder(context: context),
        'ol': TodoElementBuilder(context: context),
        'ul': TodoElementBuilder(context: context),
        'h1': TodoElementBuilder(context: context),
        'h2': TodoElementBuilder(context: context),
        'h3': TodoElementBuilder(context: context),
        'h4': TodoElementBuilder(context: context),
        'h5': TodoElementBuilder(context: context),
        'h6': TodoElementBuilder(context: context),
      },
    );
  }
}
