import 'package:flutter_test/flutter_test.dart';

abstract class Componente {
  final String id;
  final String name;

  Componente({required this.id, required this.name});

  Map<String, dynamic> render();
}

void main() {
  group('Componente', () {
    test(
        'Deve ser possível instanciar uma classe derivada de Componente com ID e nome',
        () {
      // Classe de teste derivada de Componente
      final testComponente = TestComponente(id: '1', name: 'Test Component');

      expect(testComponente.id, '1');
      expect(testComponente.name, 'Test Component');
    });

    test('Deve ser possível chamar render para obter propriedades básicas', () {
      // Classe de teste derivada de Componente
      final testComponente = TestComponente(id: '1', name: 'Test Component');
      final rendered = testComponente.render();

      expect(rendered, isA<Map<String, dynamic>>());
      expect(rendered['id'], '1');
      expect(rendered['name'], 'Test Component');
    });
  });
}

// Classe de teste concreta para a abstrata Componente
class TestComponente extends Componente {
  TestComponente({required super.id, required super.name});

  @override
  Map<String, dynamic> render() {
    return {
      'id': id,
      'name': name,
    };
  }
}
