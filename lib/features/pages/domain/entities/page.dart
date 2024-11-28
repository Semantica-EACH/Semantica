import 'package:semantica/core/component.dart';

class Page extends Component {
  final String path;
  final String title;
  final DateTime timestamp;
  final List<String> metadata;
  final String content;

  bool isEditing;

  Page({
    required this.path,
    required this.title,
    required this.timestamp,
    required this.metadata,
    required this.content,
    this.isEditing = false,
  }) : super(id: path, name: title);

  @override
  Map<String, dynamic> render() {
    return {
      'path': path,
      'name': name,
      'type': 'Page',
      'title': title,
      'timestamp': timestamp.toIso8601String(),
      'metadata': metadata,
      'content': content,
      'isEditing': isEditing,
    };
  }
}
