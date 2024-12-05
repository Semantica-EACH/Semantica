import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/markdown.dart';

class MarkdownEditor extends StatefulWidget {
  final String initialContent;
  final ValueChanged<String> onContentChanged;

  const MarkdownEditor({
    super.key,
    required this.initialContent,
    required this.onContentChanged,
  });

  @override
  _MarkdownEditorState createState() => _MarkdownEditorState();
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  late CodeController _codeController;

  @override
  void initState() {
    super.initState();
    _codeController = CodeController(
      text: widget.initialContent,
      language: markdown,
    );
    _codeController.addListener(() {
      widget.onContentChanged(_codeController.text);
    });
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final theme = isDarkMode ? monokaiSublimeTheme : githubTheme;

    return CodeTheme(
      data: CodeThemeData(styles: theme),
      child: MouseRegion(
        cursor: SystemMouseCursors.text,
        child: CodeField(
          controller: _codeController,
          maxLines: null,
          decoration: const BoxDecoration(
            border: Border.fromBorderSide(BorderSide()),
          ),
          onChanged: widget.onContentChanged,
          textStyle: const TextStyle(fontFamily: 'SourceCodePro'),
        ),
      ),
    );
  }
}
