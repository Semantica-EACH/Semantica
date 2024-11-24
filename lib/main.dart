import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/markdown_viewer/domain/usecases/render_markdown.dart';
import 'features/markdown_viewer/data/repositories/markdown_repository_impl.dart';
import 'features/markdown_viewer/data/datasources/markdown_local_datasource.dart';
import 'features/markdown_viewer/presentation/cubit/markdown_cubit.dart';
import 'features/markdown_viewer/presentation/pages/markdown_page.dart';

void main() {
  runApp(const SemanticaApp());
}

class SemanticaApp extends StatelessWidget {
  const SemanticaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Configuração das dependências
    final localDataSource = MarkdownLocalDataSource();
    final repository = MarkdownRepositoryImpl(localDataSource);
    final renderMarkdown = RenderMarkdown(repository);

    return MaterialApp(
      title: 'Semantica',
      home: BlocProvider(
        create: (_) => MarkdownCubit(renderMarkdown),
        child: const MarkdownPage(),
      ),
    );
  }
}
