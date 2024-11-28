import 'package:flutter/material.dart' as flutter;
import 'package:semantica/features/pages/domain/entities/page.dart';
import 'package:semantica/features/pages/domain/usecases/disable_editing_usecase.dart';
import 'package:semantica/features/pages/domain/usecases/enable_editing_usecase.dart';

class PageState extends flutter.ChangeNotifier {
  final Page page;
  final EnableEditingUseCase enableEditing;
  final DisableEditingUseCase disableEditing;

  PageState({
    required this.page,
    required this.enableEditing,
    required this.disableEditing,
  });

  void toggleEditing() {
    if (page.isEditing) {
      disableEditing(page);
    } else {
      enableEditing(page);
    }
    notifyListeners();
  }
}
