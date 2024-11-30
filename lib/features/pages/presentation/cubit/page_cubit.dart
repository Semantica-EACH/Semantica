import 'package:flutter_bloc/flutter_bloc.dart';
import 'page_cubit_states.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/usecases/save_page_usecase.dart';

class PageCubit extends Cubit<PageState> {
  final Page page;
  final SavePageContentUseCase savePageContentUseCase;

  PageCubit({required this.page, required this.savePageContentUseCase})
      : super(PageViewing());

  void enterEditMode() {
    emit(PageEditing());
  }

  void exitEditMode(String newContent) async {
    page.content = newContent; // Atualiza a entidade
    await savePageContentUseCase.call(page); // Salva o conteúdo
    emit(PageViewing()); // Volta ao estado de visualização
  }

  void returnToViewing() {
    emit(PageViewing()); // Retorna ao modo de visualização sem salvar
  }
}
