import 'dart:typed_data';

import 'package:semantica/features/pages/domain/entities/page.dart';

abstract class PageRepository {
  Future<void> savePageContent(Page page);
  Future<Page> getPage(String path);
  Future<Page> fromBytes(Uint8List bytes, String fileName);
}
