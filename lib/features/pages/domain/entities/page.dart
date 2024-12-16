import 'package:flutter/material.dart';
import 'package:semantica/features/block/domain/entities/block.dart';
import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';
import 'package:semantica/features/pages/presentation/widgets/page_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as p;

class Page extends Component {
  final String id;
  final String path;
  @override
  String title;
  final DateTime timestamp;
  final List<String> metadata;
  Block content;

  Page({
    String? id,
    String? path,
    String? title,
    DateTime? timestamp,
    List<String>? metadata,
    Block? content,
  })  : id = id ?? '_${Uuid().v4()}',
        path = path ?? '$id.md',
        title = title ?? (path != null ? p.basenameWithoutExtension(path) : ''),
        timestamp = timestamp ?? DateTime.now(),
        content = content ?? Block.root(),
        metadata = [],
        super(
          title: title ?? '',
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
    return id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}
