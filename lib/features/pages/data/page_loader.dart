import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/block/domain/enums/tag.dart';
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
        // Define o título com base no nome do arquivo sem a extensão
        final title = path.isNotEmpty ? p.basenameWithoutExtension(path) : '';

        // Cria uma nova página se o arquivo não for encontrado
        return Page(
          path: path,
          title: title,
          timestamp: DateTime.now(),
          metadata: [],
          content: Block(tag: Tag.root, children: []),
        );
      }

      // Lê o conteúdo do arquivo
      final content = await file.readAsString();

      // Extrai o título (nome do arquivo sem extensão)
      final title = p.basenameWithoutExtension(path);

      // Obtém o timestamp (data de criação do arquivo)
      final timestamp = await file.lastModified();

      // Retorna uma instância de Page
      return Page(
        path: path,
        title: title,
        timestamp: timestamp,
        metadata: [],
        content: Block.root(content),
      );
    } catch (e) {
      // preciso aqui lidar com arquivos que não existem
      throw Exception('Erro ao carregar o arquivo: $e');
    }
  }
}
