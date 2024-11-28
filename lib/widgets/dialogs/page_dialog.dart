import 'package:flutter/material.dart';

void showPageDialog(BuildContext context,
    {required Function(String) onSubmit}) {
  showDialog(
    context: context,
    builder: (context) {
      String? fileName;

      return AlertDialog(
        title: const Text('Abrir Página'),
        content: TextField(
          decoration:
              const InputDecoration(hintText: 'Digite o nome do arquivo'),
          onChanged: (value) {
            fileName = value;
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              if (fileName != null && fileName!.isNotEmpty) {
                onSubmit(fileName!);
              }
              Navigator.of(context).pop();
            },
            child: const Text('Abrir'),
          ),
        ],
      );
    },
  );
}
