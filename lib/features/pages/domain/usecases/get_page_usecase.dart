import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/repository/page_repository.dart';

class GetPageUseCase {
  final PageRepository repository;

  GetPageUseCase({required this.repository});

  Future<Page> call(String path) async {
    return await repository.getPage(path);
  }
}
