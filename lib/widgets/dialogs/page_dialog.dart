import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

Future<void> showPageDialog(BuildContext context,
    {required Function(String) onSubmit}) async {
  // Abre o seletor de arquivos
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom, // Pode ajustar para outros tipos
    allowedExtensions: ['md', 'txt'], // Apenas arquivos específicos
  );

  if (result != null && result.files.single.path != null) {
    // Chama o callback com o caminho do arquivo
    onSubmit(result.files.single.path!);
  } else {
    // O usuário cancelou a seleção
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Nenhum arquivo selecionado')),
    );
  }
}
