import 'package:semantica/features/component/domain/entities/component.dart';

class Page implements Component {
  final String path;
  @override
  String title;
  DateTime timestamp;
  List<String> metadata;
  String content;

  Page({
    required this.path,
    required this.title,
    required this.timestamp,
    required this.metadata,
    required this.content,
  }) : super();
}
