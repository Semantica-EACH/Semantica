import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
// import 'package:highlight/languages/d.dart';
import 'package:semantica/core/markdown/markdown_viewer.dart';
//import 'package:semantica/core/markdown/markdown_editor.dart';
//import 'package:semantica/core/markdown/markdown_viewer.dart';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/block/domain/enums/tag.dart';
import 'package:semantica/features/block/presentation/cubit/block_cubit.dart';
import 'package:semantica/features/pages/domain/entities/page.dart' as my_page;
import 'package:semantica/features/pages/presentation/cubit/page_cubit.dart';

class BlockWidget extends StatefulWidget {
  final Block block;
  final my_page.Page page;
  final int depth;

  const BlockWidget(
      {super.key, required this.block, required this.page, this.depth = 0});

  @override
  _BlockWidgetState createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget> {
  final FocusNode focusNode = FocusNode();
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final pageCubit = context.read<PageCubit>();

    return BlocProvider(
      create: (_) => BlockCubit(widget.block),
      child: BlocBuilder<BlockCubit, BlockState>(
        builder: (context, state) {
          final blockCubit = context.read<BlockCubit>();

          // Listener para alternar entre edição e visualização
          focusNode.addListener(() {
            if (!focusNode.hasFocus && state is BlockEditing) {
              pageCubit.savePage(widget.page.content.toMarkdown());
              blockCubit.returnToViewing();
            }
          });

          return GestureDetector(
            onTap: () {
              if (state is BlockViewing) {
                focusNode.requestFocus(); // Alterna para o modo de edição
                blockCubit.enterEditMode();
              }
            },
            child: Focus(
              focusNode: focusNode,
              child: BlocBuilder<BlockCubit, BlockState>(
                builder: (context, state) {
                  /*         if (state is BlockEditing) {
                    return MarkdownEditor(
                      initialContent: block.toMarkdown(),
                      onContentChanged: (newContent) {
                        blockCubit.saveBlock(newContent);
                      },
                    );
                  } else {*/
                  // return MarkdownViewer(markdownContent: block.toMarkdown());
                  return _buildBlockView(widget.block, widget.depth);

                  // }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBlockView(Block block, int depth) {
    if (block.tag == Tag.root) {
      return Column(
        children: block.children
            .map((child) => BlockWidget(
                  page: widget.page,
                  block: child,
                  depth: depth,
                ))
            .toList(),
      );
    }

    if (block.tag == Tag.ul) {
      depth++;
    }

    Widget expansionTile = Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: _buildHeader(block),
        initiallyExpanded: isExpanded,
        onExpansionChanged: (expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        trailing: block.children.isNotEmpty
            ? Icon(
                isExpanded ? Icons.expand_more : Icons.chevron_left,
                color: Theme.of(context).iconTheme.color,
              )
            : SizedBox.shrink(),
        children: block.children
            .map((child) => BlockWidget(
                  page: widget.page,
                  block: child,
                  depth: depth,
                ))
            .toList(),
      ),
    );

    if (block.tag == Tag.ul) {
      return Padding(
        padding: EdgeInsets.only(left: depth * 16.0),
        child: expansionTile,
      );
    }

    return expansionTile;
  }

  Widget _buildHeader(Block block) {
    switch (block.tag) {
      case Tag.h1:
        return MarkdownViewer(markdownContent: "# ${block.header?.text}");
      case Tag.h2:
        return MarkdownViewer(markdownContent: "## ${block.header?.text}");
      case Tag.h3:
        return MarkdownViewer(markdownContent: "### ${block.header?.text}");
      case Tag.h4:
        return MarkdownViewer(markdownContent: "#### ${block.header?.text}");
      case Tag.h5:
        return MarkdownViewer(markdownContent: "##### ${block.header?.text}");
      case Tag.h6:
        return MarkdownViewer(markdownContent: "###### ${block.header?.text}");
      // falta o ol
      case Tag.ul:
        return Row(
          children: [
            Icon(Icons.circle,
                size: 8, color: Theme.of(context).iconTheme.color),
            SizedBox(width: 8),
            Flexible(
              child: MarkdownViewer(markdownContent: block.header?.text ?? ''),
            )
          ],
        );
      case Tag.p:
      default:
        return MarkdownViewer(markdownContent: block.header?.text ?? '');
    }
  }
}
