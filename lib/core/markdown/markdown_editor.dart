import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/markdown.dart';

class MarkdownEditor extends StatefulWidget {
  final String initialContent;
  final ValueChanged<String> onContentChanged;
  final FocusNode? focusNode;

  const MarkdownEditor({
    super.key,
    required this.initialContent,
    required this.onContentChanged,
    this.focusNode,
  });

  @override
  _MarkdownEditorState createState() => _MarkdownEditorState();
}

class _MarkdownEditorState extends State<MarkdownEditor> {
  late CodeController _codeController;

  @override
  void initState() {
    super.initState();

    print(
        "FocusNode criado: ${widget.focusNode} para widget: ${widget.hashCode}");

    if (widget.focusNode != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && widget.focusNode!.canRequestFocus) {
          widget.focusNode!.requestFocus();
        }
      });
    }

    _codeController = CodeController(
      text: widget.initialContent,
      language: markdown,
    );

    _codeController.addListener(() {
      widget.onContentChanged(_codeController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    final theme = isDarkMode ? monokaiSublimeTheme : githubTheme;

    return CodeTheme(
      data: CodeThemeData(styles: theme),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 50,
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: CodeField(
          lineNumbers: false,
          controller: _codeController,
          maxLines: null,
          focusNode: widget.focusNode,
          enabled: true,
          onChanged: widget.onContentChanged,
          textStyle: const TextStyle(fontFamily: 'SourceCodePro'),
        ),
      ),
    );
  }
}
