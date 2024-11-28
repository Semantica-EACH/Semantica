import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter/material.dart';

/// Editor de Markdown com realce de sintaxe
class MarkdownEditor extends StatelessWidget {
  final String initialContent;
  final ValueChanged<String> onContentChanged;

  const MarkdownEditor({
    super.key,
    required this.initialContent,
    required this.onContentChanged,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
        TextEditingController(text: initialContent);

    return Column(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            maxLines: null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Digite o conteúdo Markdown aqui...',
            ),
            onChanged: onContentChanged,
          ),
        ),
        Expanded(
          child: HighlightView(
            controller.text,
            language: 'markdown',
            theme: githubTheme,
            padding: const EdgeInsets.all(16),
            textStyle: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
