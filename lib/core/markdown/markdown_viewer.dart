import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:semantica/core/markdown/widgets/local_link_builder.dart';

class MarkdownViewer extends StatefulWidget {
  final String markdownContent;

  const MarkdownViewer({
    super.key,
    required this.markdownContent,
  });

  @override
  _MarkdownViewerState createState() => _MarkdownViewerState();
}

class _MarkdownViewerState extends State<MarkdownViewer> {
  @override
  Widget build(BuildContext context) {
    return MarkdownBody(
        data: widget.markdownContent,
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)),
        builders: {
          'p': LocalLinkBuilder(context: context),
          'li': LocalLinkBuilder(context: context),
          'h1': LocalLinkBuilder(context: context),
          'h2': LocalLinkBuilder(context: context),
          'h3': LocalLinkBuilder(context: context),
          'h4': LocalLinkBuilder(context: context),
          'h5': LocalLinkBuilder(context: context),
          'h6': LocalLinkBuilder(context: context),
        });
  }
}
