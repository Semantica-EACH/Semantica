import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:semantica/core/utils/preferences_util.dart';

class ConfigurationsModal extends StatefulWidget {
  const ConfigurationsModal({super.key});

  @override
  _ConfigurationsModalState createState() => _ConfigurationsModalState();
}

class _ConfigurationsModalState extends State<ConfigurationsModal> {
  String? _selectedDirectory;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    final selectedDirectory = await PreferencesUtil.getString('repository');
    setState(() {
      _selectedDirectory = selectedDirectory;
    });
  }

  Future<void> _selectDirectory() async {
    String? directoryPath = await FilePicker.platform.getDirectoryPath();
    if (directoryPath != null) {
      setState(() {
        _selectedDirectory = directoryPath;
      });
      await PreferencesUtil.setString('repository', directoryPath);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Configurações'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              title: const Text('Pasta de Repositório'),
              subtitle: Text(_selectedDirectory ?? 'Nenhuma pasta selecionada'),
              trailing: IconButton(
                icon: const Icon(Icons.folder_open),
                onPressed: _selectDirectory,
              ),
            ),
            // Adicione mais opções conforme necessário
          ],
        ),
      ),
    );
  }
}
