import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/core/markdown/markdown_viewer.dart';
import 'package:semantica/core/markdown/markdown_editor.dart';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/block/domain/enums/tag.dart';
import 'package:semantica/features/block/presentation/cubit/block_cubit.dart';
import 'package:semantica/features/block/presentation/widgets/custom_expansion_tile.dart';
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
                focusNode.requestFocus();
                blockCubit.enterEditMode();
              }
            },
            child: Focus(
              focusNode: focusNode,
              child: BlocBuilder<BlockCubit, BlockState>(
                builder: (context, state) {
                  if (state is BlockEditing) {
                    return MarkdownEditor(
                      initialContent: widget.block.toMarkdown(),
                      onContentChanged: (newContent) {
                        blockCubit.saveBlock(
                            newContent); // isso ainda não foi implementado
                      },
                    );
                  } else {
                    return _buildBlockView(widget.block, widget.depth);
                  }
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

    double verticalPadding;

    switch (block.tag) {
      case Tag.h1:
      case Tag.h2:
        verticalPadding = 12.0;
        break;
      case Tag.h3:
      case Tag.h4:
        verticalPadding = 10.0;
        break;
      default:
        verticalPadding = 8.0;
    }

    EdgeInsetsGeometry tilePadding =
        EdgeInsets.symmetric(vertical: verticalPadding);

    if (block.tag.isListItem()) {
      depth++;
    }

    Widget expansionTile = Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: CustomExpansionTile(
        tilePadding: tilePadding,
        title: _buildHeader(block),
        initiallyExpanded: isExpanded,
        children: block.children
            .map((child) => BlockWidget(
                  page: widget.page,
                  block: child,
                  depth: depth,
                ))
            .toList(),
      ),
    );

    if (block.tag.isListItem()) {
      return Padding(
        padding: EdgeInsets.only(left: depth * 8.0),
        child: expansionTile,
      );
    }

    return expansionTile;
  }

  Widget _buildHeader(Block block) {
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
            Icon(Icons.circle,
                size: 8, color: Theme.of(context).iconTheme.color),
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
}
