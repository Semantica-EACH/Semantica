import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

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

  Future<Page> fromBytes(Uint8List bytes, String fileName) async {
    try {
      // Converte os bytes em string (para arquivos de texto)
      String content = utf8.decode(bytes);

      // Extração de dados
      String title =
          fileName.split('.').first; // Título baseado no nome do arquivo
      DateTime timestamp = DateTime.now(); // Timestamp atual
      List<String> metadata = _extractMetadata(content); // Metadados

      // Retorna a entidade Page
      return Page(
        path: fileName, // Nome do arquivo na Web
        title: title,
        timestamp: timestamp,
        metadata: metadata,
        content: content,
      );
    } catch (e) {
      throw Exception("Erro ao processar bytes do arquivo: $e");
    }
  }

// Função auxiliar para extrair metadados
  List<String> _extractMetadata(String content) {
    // Exemplo: Extraia linhas que começam com '#'
    return content.split('\n').where((line) => line.startsWith('#')).toList();
  }
}
