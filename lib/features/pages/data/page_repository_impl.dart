import 'dart:io';

import 'package:semantica/features/pages/data/page_loader.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/repository/page_repository.dart';

class PageRepositoryImpl implements PageRepository {
  final PageLoader pageLoader;

  PageRepositoryImpl({required this.pageLoader});

  @override
  Future<void> savePageContent(Page page) async {
    final file = File(page.path);

    try {
      await file.writeAsString(page.content); // Salva o conteúdo no arquivo
    } catch (e) {
      throw Exception('Erro ao salvar o conteúdo: $e');
    }
  }

  @override
  Future<Page> getPage(String path) async {
    return await pageLoader.loadPage(path);
  }
}
