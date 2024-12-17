import 'package:flutter/material.dart';
import 'package:semantica/core/markdown/markdown_viewer.dart';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/block/domain/enums/tag.dart';

Widget buildHeader(Block block, BuildContext context) {
  if (block.tag.isHeader()) {
    int? level = block.tag.headerLevel();
    if (level != null) {
      return MarkdownViewer(
          markdownContent: "${'#' * level} ${block.header?.text}");
    }
  }

  switch (block.tag) {
    case Tag.ul:
      return Row(
        children: [
          Icon(Icons.circle, size: 8, color: Theme.of(context).iconTheme.color),
          SizedBox(width: 8),
          Flexible(
            child: MarkdownViewer(markdownContent: block.header?.text ?? ''),
          ),
        ],
      );
    case Tag.p:
    default:
      return MarkdownViewer(markdownContent: block.header?.text ?? '');
  }
}
