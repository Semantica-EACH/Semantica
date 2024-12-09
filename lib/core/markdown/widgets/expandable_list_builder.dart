import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:semantica/core/markdown/widgets/local_link_builder.dart';

class ExpandableListBuilder extends MarkdownElementBuilder {
  final BuildContext context;
  final String tag;

  ExpandableListBuilder({
    required this.context,
    required this.tag,
  });

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    // Garantir que estamos lidando apenas com elementos de lista
    return ExpandableListTile(
      element: element,
      preferredStyle: preferredStyle,
    );
  }

  @override
  Widget? visitText(md.Text text, TextStyle? preferredStyle) {
    TextStyle? style;

    switch (tag) {
      case 'h1':
        style = Theme.of(context).textTheme.headlineLarge;
        break;
      case 'h2':
        style = Theme.of(context).textTheme.headlineMedium;
        break;
      case 'h3':
        style = Theme.of(context).textTheme.headlineSmall;
        break;
      case 'p':
      case 'li':
        style = Theme.of(context).textTheme.bodyMedium;
        break;
      default:
        style = preferredStyle;
    }

    return LocalLinkBuilder(context: context).visitText(text, style);
  }
}

class ExpandableListTile extends StatefulWidget {
  final md.Element element;
  final TextStyle? preferredStyle;

  ExpandableListTile({
    required this.element,
    required this.preferredStyle,
  });

  @override
  _ExpandableListTileState createState() => _ExpandableListTileState();
}

class _ExpandableListTileState extends State<ExpandableListTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return _buildElement(widget.element);
  }

  Widget _buildElement(md.Element element) {
    String title = '';
    List<md.Element>? childrenNodes = [];

    for (var child in element.children!) {
      if (child is md.Text) {
        title = child.text;
      } else if (child is md.Element) {
        childrenNodes = child.children?.cast<md.Element>();
      }
    }

    return _buildColumn(title, childrenNodes!);
  }

  Widget _buildColumn(String title, List<md.Element> childrenNodes) {
    bool hasChildren = childrenNodes.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildListTile(title, hasChildren),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: childrenNodes
                  .map((child) => _buildChildWidget(child))
                  .toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildListTile(String title, bool hasChildren) {
    return ListTile(
      title: LocalLinkBuilder(context: context)
          .visitText(md.Text(title), widget.preferredStyle),
      trailing: hasChildren
          ? Icon(
              _isExpanded ? Icons.expand_less : Icons.expand_more,
            )
          : null,
      onTap: hasChildren
          ? () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            }
          : null,
    );
  }

  Widget _buildChildWidget(md.Element child) {
    return ExpandableListTile(
      element: child,
      preferredStyle: widget.preferredStyle,
    );
  }
}
