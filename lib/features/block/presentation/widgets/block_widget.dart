import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/core/markdown/markdown_editor.dart';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/block/domain/enums/tag.dart';
import 'package:semantica/features/block/presentation/cubit/block_cubit.dart';
import 'package:semantica/features/block/presentation/widgets/block_view_builder.dart';
import 'package:semantica/features/pages/domain/entities/page.dart' as my_page;

class BlockWidget extends StatefulWidget {
  final Block block;
  final my_page.Page page;
  final int depth;

  const BlockWidget({
    super.key,
    required this.block,
    required this.page,
    this.depth = 0,
  });

  @override
  _BlockWidgetState createState() => _BlockWidgetState();
}

class _BlockWidgetState extends State<BlockWidget> {
  FocusNode? focusNode;
  bool isExpanded = true;
  static Block? focusedBlock;

  @override
  void dispose() {
    focusNode?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlockCubit(widget.block),
      child: Builder(
        builder: (context) {
          final blockCubit = context.read<BlockCubit>();

          if (widget.block.tag == Tag.root && widget.block.children.isEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                focusedBlock = widget.block;
              });
              focusNode?.requestFocus();
              blockCubit.enterEditMode();
            });
          }

          return BlocBuilder<BlockCubit, BlockState>(
            builder: (context, state) {
              if (state is BlockEditing) {
                // Cria um FocusNode apenas quando o bloco está em edição
                focusNode ??= FocusNode();

                if (focusedBlock != widget.block) {
                  focusedBlock = widget.block;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      focusNode?.requestFocus();
                    }
                  });
                }

                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    // Permite sair do modo edição ao clicar fora do editor
                    if (focusNode?.hasFocus ?? false) {
                      focusNode?.unfocus();
                      blockCubit.returnToViewing();
                    }
                  },
                  child: MarkdownEditor(
                    initialContent: widget.block.toMarkdown(),
                    onContentChanged: (newContent) {
                      blockCubit.saveBlock(newContent);
                    },
                    focusNode: focusNode, // Usa o FocusNode local
                  ),
                );
              } else {
                // Se o bloco não está em edição, limpa o FocusNode
                focusNode?.dispose();
                focusNode = null;

                return GestureDetector(
                  onTap: () {
                    // Atualiza o estado do bloco para edição ao clicar
                    blockCubit.enterEditMode();
                  },
                  child: Container(
                    child: buildBlockView(context, widget.block, widget.depth,
                        state, widget.page),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
