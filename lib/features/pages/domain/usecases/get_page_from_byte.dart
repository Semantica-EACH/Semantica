import 'dart:typed_data';

import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/repository/page_repository.dart';

class GetPageFromBytesUseCase {
  final PageRepository repository;

  GetPageFromBytesUseCase({required this.repository});

  Future<Page> call(Uint8List bytes, String fileName) {
    return repository.fromBytes(bytes, fileName);
  }
}
