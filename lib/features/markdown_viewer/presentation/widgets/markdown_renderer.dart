import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MarkdownRenderer extends StatelessWidget {
  final String content;

  const MarkdownRenderer({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Markdown(data: content);
  }
}
