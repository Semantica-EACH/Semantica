import 'package:semantica/features/pages/domain/entities/page.dart';

class DisableEditingUseCase {
  void call(Page page) {
    page.isEditing = false;
  }
}
