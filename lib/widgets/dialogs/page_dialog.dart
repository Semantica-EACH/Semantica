import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data'; // Para lidar com bytes

Future<void> showPageDialog(BuildContext context,
    {required Function(String, Uint8List?) onSubmit}) async {
  // Abre o seletor de arquivos
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom, // Pode ajustar para outros tipos
    allowedExtensions: ['md', 'txt'], // Apenas arquivos específicos
  );

  if (result != null) {
    // Nome do arquivo
    String fileName = result.files.single.name;

    // Bytes do arquivo (necessário na web)
    Uint8List? fileBytes = result.files.single.bytes;

    if (fileBytes != null) {
      // Envia o nome e os bytes para o callback
      onSubmit(fileName, fileBytes);
    } else if (result.files.single.path != null) {
      // Caso não esteja na web, use o caminho local
      onSubmit(result.files.single.path!, null);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao acessar o arquivo')),
      );
    }
  } else {
    // O usuário cancelou a seleção
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nenhum arquivo selecionado')),
    );
  }
}
