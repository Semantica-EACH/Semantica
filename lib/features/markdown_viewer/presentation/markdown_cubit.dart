import 'package:bloc/bloc.dart';
import '../domain/entities/markdown_content.dart';
import '../domain/usecases/render_markdown.dart';

class MarkdownCubit extends Cubit<MarkdownContent?> {
  final RenderMarkdown renderMarkdown;

  MarkdownCubit(this.renderMarkdown) : super(null);

  Future<void> loadMarkdown() async {
    try {
      final content = await renderMarkdown();
      emit(content);
    } catch (e) {
      emit(null); // Ou emita um estado de erro personalizado.
    }
  }
}
