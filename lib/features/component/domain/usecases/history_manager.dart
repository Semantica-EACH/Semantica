import 'package:semantica/features/component_collection/domain/entities/central_stack.dart';

class HistoryManager {
  /// Navega para o componente anterior na pilha
  void undo(CentralStack centralStack) {
    centralStack.navigateToPrevious();
  }

  /// Navega para o próximo componente na pilha
  void redo(CentralStack centralStack) {
    centralStack.navigateToNext();
  }
}
