import 'dart:io';

import 'package:flutter/material.dart';

import 'package:semantica/core/component.dart';
import 'package:semantica/features/pages/presentation/widgets/page_widget.dart';

class Page extends Component {
  String path;
  String title;
  DateTime timestamp;
  List<String> metadata;
  String content;

  bool isEditing;

  Page({
    required this.path,
    required this.title,
    required this.timestamp,
    required this.metadata,
    required this.content,
    this.isEditing = false,
  }) : super(id: path, name: title);

  void saveContent() {
    final file = File(path);
    file.writeAsStringSync(content); // Salva o conteúdo no arquivo
  }

  @override
  Widget render() {
    return PageWidget(page: this); // Usa o widget específico da página
  }
}
