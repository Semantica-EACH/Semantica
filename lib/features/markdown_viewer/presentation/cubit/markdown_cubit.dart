import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/markdown_content.dart';
import '../../domain/usecases/render_markdown.dart';

class MarkdownCubit extends Cubit<MarkdownContent?> {
  final RenderMarkdown renderMarkdown;

  MarkdownCubit(this.renderMarkdown) : super(null);

  Future<void> loadMarkdown() async {
    try {
      final content = await renderMarkdown();
      emit(content);
    } catch (e) {
      emit(null); // Pode emitir um estado de erro se necessário.
    }
  }
}
