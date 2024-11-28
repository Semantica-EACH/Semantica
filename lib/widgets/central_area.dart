import 'package:flutter/material.dart';
import 'package:semantica/core/component.dart';
import 'package:semantica/features/pages/domain/entities/page.dart' as my_page;
import 'package:flutter_markdown/flutter_markdown.dart';

class CentralArea extends StatelessWidget {
  final Component? component;

  const CentralArea({super.key, this.component});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: component == null
          ? const Center(
              child: Text(
                'Nenhum componente carregado',
                style: TextStyle(fontSize: 20),
              ),
            )
          : _renderComponent(component!),
    );
  }

  Widget _renderComponent(Component component) {
    if (component is my_page.Page) {
      // Renderização específica para Page
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              component.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Markdown(
                data: component.content,
              ),
            ),
          ),
        ],
      );
    } else {
      // Renderização genérica para outros tipos de Component
      return Center(
        child: Text(
          'Componente não suportado: ${component.runtimeType}',
          style: const TextStyle(fontSize: 18),
        ),
      );
    }
  }
}
