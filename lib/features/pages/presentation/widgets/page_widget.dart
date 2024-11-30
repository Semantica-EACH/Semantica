import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/core/markdown/markdown_editor.dart';
import 'package:semantica/core/markdown/markdown_viewer.dart';
import 'package:semantica/core/presentation/component.dart';
import 'package:semantica/features/pages/domain/entities/page.dart' as my_page;
import 'package:semantica/features/pages/domain/usecases/save_page_usecase.dart';
import 'package:semantica/features/pages/presentation/cubit/page_cubit.dart';
import 'package:semantica/features/pages/presentation/cubit/page_cubit_states.dart';

class PageWidget extends StatelessWidget implements Component {
  final my_page.Page page;
  final SavePageContentUseCase savePageContentUseCase;

  const PageWidget({
    super.key,
    required this.page,
    required this.savePageContentUseCase,
  });

  @override
  Widget renderCentral(BuildContext context) {
    return this; // Renderiza o próprio widget para a área central
  }

  @override
  Widget renderSidebar(BuildContext context) {
    return ListTile(
      title: Text(page.title),
      subtitle: Text('Última modificação: ${page.timestamp}'),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Clicou na página!')),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          PageCubit(page: page, savePageContentUseCase: savePageContentUseCase),
      child: BlocBuilder<PageCubit, PageState>(
        builder: (context, state) {
          final pageCubit = context.read<PageCubit>();
          final FocusNode focusNode = FocusNode();

          focusNode.addListener(() {
            if (!focusNode.hasFocus && state is PageEditing) {
              pageCubit.returnToViewing(); // Volta para visualização
            }
          });

          return GestureDetector(
            onTap: () {
              if (state is PageViewing) {
                focusNode.requestFocus(); // Alterna para o modo de edição
                pageCubit.enterEditMode();
              }
            },
            child: Focus(
              focusNode: focusNode,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      page.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: state is PageEditing
                          ? MarkdownEditor(
                              initialContent: page.content,
                              onContentChanged: (newContent) {
                                pageCubit.exitEditMode(newContent);
                              },
                            )
                          : MarkdownViewer(
                              markdownContent: page.content,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
