import 'package:flutter/material.dart';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/block/domain/enums/tag.dart';
import 'package:semantica/features/block/presentation/cubit/block_cubit.dart';
import 'package:semantica/features/block/presentation/widgets/block_header_builder.dart';
import 'package:semantica/features/block/presentation/widgets/block_widget.dart';
import 'package:semantica/features/block/presentation/widgets/custom_expansion_tile.dart';
import 'package:semantica/features/pages/domain/entities/page.dart' as my_page;

Widget buildBlockView(BuildContext context, Block block, int depth,
    BlockState state, my_page.Page page) {
  if (block.tag == Tag.root) {
    return Column(
      children: block.children
          .where((child) => child != block)
          .map((child) => BlockWidget(
                page: page,
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
      title: buildHeader(block, context),
      initiallyExpanded: true,
      children: block.children
          .map((child) => BlockWidget(
                page: page,
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
