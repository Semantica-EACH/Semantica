import 'package:semantica/features/pages/domain/entities/page.dart';

class EnableEditingUseCase {
  void call(Page page) {
    page.isEditing = true;
  }
}
