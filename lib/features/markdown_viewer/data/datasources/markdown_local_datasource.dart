import 'dart:io';

class MarkdownLocalDataSource {
  Future<String> readMarkdownFile(String filePath) async {
    final file = File(filePath);

    if (await file.exists()) {
      return file.readAsString();
    } else {
      throw Exception('Arquivo não encontrado: $filePath');
    }
  }
}
