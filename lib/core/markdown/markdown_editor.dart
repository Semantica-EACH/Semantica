import 'package:flutter/material.dart';

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
        TextField(
            controller: controller,
            maxLines: null,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Digite o conteúdo Markdown aqui...',
            ),
            onChanged: onContentChanged,
          ),
      ],
    );
  }
}
