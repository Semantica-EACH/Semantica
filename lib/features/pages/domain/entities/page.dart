class Page {
  final String path;
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
