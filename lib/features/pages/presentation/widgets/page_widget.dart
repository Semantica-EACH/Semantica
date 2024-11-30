import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:semantica/core/markdown/markdown_editor.dart';
import 'package:semantica/core/markdown/markdown_viewer.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';
import 'package:semantica/features/pages/domain/entities/page.dart' as my_page;
import 'package:semantica/features/pages/domain/usecases/save_page_usecase.dart';
import 'package:semantica/features/pages/presentation/cubit/page_cubit.dart';
import 'package:semantica/features/pages/presentation/cubit/page_cubit_states.dart';

// ignore: must_be_immutable
class PageWidget extends ComponentView {
  @override
  final my_page.Page component;
  final SavePageContentUseCase savePageContentUseCase;

  PageWidget(
      {super.key,
      required super.isExpanded,
      required this.component,
      required this.savePageContentUseCase});

  /// Renderização principal compartilhada
  Widget _buildMainContent(BuildContext context, PageState state,
      {bool isCentral = false}) {
    final pageCubit = context.read<PageCubit>();
    final FocusNode focusNode = FocusNode();

    // Listener para alternar entre edição e visualização
    focusNode.addListener(() {
      if (!focusNode.hasFocus && state is PageEditing) {
        pageCubit.returnToViewing();
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
          crossAxisAlignment:
              isCentral ? CrossAxisAlignment.center : CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                component.title,
                style: TextStyle(
                  fontSize: isCentral ? 24 : 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (isCentral)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: state is PageEditing
                      ? MarkdownEditor(
                          initialContent: component.content,
                          onContentChanged: (newContent) {
                            pageCubit.exitEditMode(newContent);
                          },
                        )
                      : MarkdownViewer(
                          markdownContent: component.content,
                        ),
                ),
              )
            else
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: state is PageEditing
                      ? const Text("Modo de edição ativo")
                      : const Text("Modo Visualização.")),
          ],
        ),
      ),
    );
  }

  @override
  Widget renderCentralContent(BuildContext context) {
    return BlocProvider(
      create: (_) => PageCubit(
          page: component, savePageContentUseCase: savePageContentUseCase),
      child: BlocBuilder<PageCubit, PageState>(
        builder: (context, state) {
          return _buildMainContent(context, state, isCentral: true);
        },
      ),
    );
  }

  @override
  Widget renderSidebarContent(BuildContext context) {
    return BlocProvider(
      create: (_) => PageCubit(
          page: component, savePageContentUseCase: savePageContentUseCase),
      child: BlocBuilder<PageCubit, PageState>(
        builder: (context, state) {
          return _buildMainContent(context, state, isCentral: false);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PageCubit(
          page: component, savePageContentUseCase: savePageContentUseCase),
      child: BlocBuilder<PageCubit, PageState>(
        builder: (context, state) {
          return _buildMainContent(context, state, isCentral: true);
        },
      ),
    );
  }
}
