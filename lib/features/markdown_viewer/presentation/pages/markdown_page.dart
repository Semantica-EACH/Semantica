import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/markdown_content.dart';
import '../widgets/markdown_renderer.dart';
import '../cubit/markdown_cubit.dart';

class MarkdownPage extends StatelessWidget {
  const MarkdownPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Markdown Viewer')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.read<MarkdownCubit>().loadMarkdown();
            },
            child: const Text('Carregar Markdown'),
          ),
          Expanded(
            child: BlocBuilder<MarkdownCubit, MarkdownContent?>(
              builder: (context, markdownContent) {
                if (markdownContent == null) {
                  return const Center(
                    child: Text('Nenhum conteúdo carregado.'),
                  );
                }
                return MarkdownRenderer(content: markdownContent.content);
              },
            ),
          ),
        ],
      ),
    );
  }
}
