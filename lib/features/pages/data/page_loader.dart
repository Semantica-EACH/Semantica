import 'dart:io';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/pages/domain/entities/page.dart';

typedef FileFactory = File Function(String path);

class PageLoader {
  final FileFactory fileFactory;

  PageLoader({FileFactory? fileFactory})
      : fileFactory = fileFactory ?? ((path) => File(path));

  Future<Page> loadPage(String path) async {
    try {
      final file = fileFactory(path);

      // Verifica se o arquivo existe
      if (!await file.exists()) {
        // Cria uma nova página se o arquivo não for encontrado
        return Page(
          path: path,
        );
      }

      // Lê o conteúdo do arquivo
      final content = await file.readAsString();

      // Obtém o timestamp (data de criação do arquivo)
      final timestamp = await file.lastModified();

      // Retorna uma instância de Page
      return Page(
        path: path,
        timestamp: timestamp,
        content: Block.root(markdown: content),
      );
    } catch (e) {
      // preciso aqui lidar com arquivos que não existem
      throw Exception('Erro ao carregar o arquivo: $e');
    }
  }
}
