import 'package:semantica/features/component/presentation/widgets/component_view.dart';

class OpenComponentUseCase {
  /// Atualiza os estados dos componentes para maximizar um
  Map<String, dynamic> call(ComponentView centralComponent) {
    
    return {
      'centralComponent': centralComponent
    };
  }
}