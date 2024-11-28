import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter/material.dart';

class MarkdownRenderer extends StatelessWidget {
  final String markdownContent;

  const MarkdownRenderer({
    super.key,
    required this.markdownContent,
  });

  @override
  Widget build(BuildContext context) {
    return HighlightView(
      markdownContent,
      language: 'markdown',
      theme: githubTheme,
      padding: const EdgeInsets.all(16),
      textStyle: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 16,
      ),
    );
  }
}
