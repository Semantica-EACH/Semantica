import 'dart:convert';
import 'dart:typed_data';

import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/repository/page_repository.dart';

class GetPageUseCase {
  final PageRepository repository;

  GetPageUseCase({required this.repository});

  Future<Page> call(String path) async {
    return await repository.getPage(path);
  }

  // Função auxiliar para extrair metadados do conteúdo
  List<String> _extractMetadata(String content) {
    // Exemplo: Extraia metadados com base em um formato específico
    // Aqui estamos apenas simulando a extração como exemplo
    return content.split('\n').where((line) => line.startsWith('#')).toList();
  }
}
