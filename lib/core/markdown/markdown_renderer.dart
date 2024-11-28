// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

/// Renderizador de Markdown reutilizável
class MarkdownRenderer extends StatelessWidget {
  final String markdownContent;

  const MarkdownRenderer({
    super.key,
    required this.markdownContent,
  });

  @override
  Widget build(BuildContext context) {
    return Markdown(
      data: markdownContent,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
    );
  }
}
