import 'package:flutter/material.dart';
import 'package:semantica/core/markdown/markdown_editor.dart';
import 'package:semantica/core/markdown/markdown_viewer.dart';
import 'package:semantica/features/pages/domain/entities/page.dart' as my_page;

class PageWidget extends StatefulWidget {
  final my_page.Page page;

  const PageWidget({super.key, required this.page});

  @override
  State<PageWidget> createState() => _PageWidgetState();
}

class _PageWidgetState extends State<PageWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // Salvar o conteúdo ao perder o foco
        widget.page.saveContent();
      }
      setState(() {
        widget.page.isEditing = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus(); // Força o foco no widget ao clicar
      },
      child: Focus(
        focusNode: _focusNode,
        canRequestFocus: true, // Permite que o widget receba foco
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.page.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: widget.page.isEditing
                    ? MarkdownEditor(
                        initialContent: widget.page.content,
                        onContentChanged: (newContent) {
                          widget.page.content = newContent;
                        },
                      )
                    : MarkdownViewer(
                        markdownContent: widget.page.content,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
