import 'package:flutter_test/flutter_test.dart';

import 'package:semantica/main.dart';

void main() {
  testWidgets('A página inicial carrega corretamente',
      (WidgetTester tester) async {
    // Construa o app e inicie o frame.
    await tester.pumpWidget(const SemanticaApp());

    // Verifique se o botão "Carregar Markdown" está presente.
    expect(find.text('Carregar Markdown'), findsOneWidget);

    // Verifique se a mensagem inicial é exibida.
    expect(find.text('Nenhum conteúdo carregado.'), findsOneWidget);
  });
}
