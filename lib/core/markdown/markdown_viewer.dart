import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:semantica/core/markdown/widgets/expandable_list_builder.dart';

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
        'li': ExpandableListBuilder(
          context: context,
          tag: 'li',
        ),
        'h1': ExpandableListBuilder(
          context: context,
          tag: 'h1',
        ),
        'h2': ExpandableListBuilder(
          context: context,
          tag: 'h2',
        ),
        'h3': ExpandableListBuilder(
          context: context,
          tag: 'h3',
        ),
        'h4': ExpandableListBuilder(
          context: context,
          tag: 'h4',
        ),
        'h5': ExpandableListBuilder(
          context: context,
          tag: 'h5',
        ),
        'h6': ExpandableListBuilder(
          context: context,
          tag: 'h6',
        ),
        'p': ExpandableListBuilder(
          context: context,
          tag: 'p',
        ),
      },
    );
  }
}
