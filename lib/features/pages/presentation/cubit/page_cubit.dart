import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/usecases/save_page_usecase.dart';

class PageCubit extends Cubit {
  final Page page;
  final SavePageContentUseCase savePageContentUseCase;

  PageCubit(super.initialState,
      {required this.page, required this.savePageContentUseCase});

  Future<void> savePage(String newContent) async {
    page.content = Block.fromMarkdown(newContent); // Atualiza a entidade
    await savePageContentUseCase.call(page); // Salva o conteúdo
  }
}
