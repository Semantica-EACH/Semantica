import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/repository/page_repository.dart';

class SavePageContentUseCase {
  final PageRepository repository;

  SavePageContentUseCase({required this.repository});

  Future<void> call(Page page) async {
    await repository.savePageContent(page);
  }
}
