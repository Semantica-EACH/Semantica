import 'package:flutter/material.dart';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';
import 'package:semantica/features/pages/presentation/widgets/page_widget.dart';

class Page extends Component {
  final String path;
  @override
  String title;
  final DateTime timestamp;
  final List<String> metadata;
  Block content;

  Page({
    required this.path,
    required this.title,
    required this.timestamp,
    required this.metadata,
    required this.content,
  }) : super(
          title: title,
          icon: Icons.note,
        );

  @override
  ComponentView toComponentView() {
    return PageWidget(component: this);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Page) return false;
    return path == other.path;
  }

  @override
  int get hashCode => path.hashCode;
}
