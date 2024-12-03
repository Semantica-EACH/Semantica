import 'package:semantica/features/component_list/domain/entities/central_stack.dart';

class RedoUseCase {
  /// Atualiza os estados dos componentes para maximizar um
  void call(CentralStack centralStack) {
    // Verifica se o componente está na barra lateral
    centralStack.navigateToNext();
  }
}
