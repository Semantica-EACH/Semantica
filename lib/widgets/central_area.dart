import 'package:flutter/material.dart';
import 'package:semantica/core/component.dart';

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
    return component.render(); // Delegação para o método render do componente
  }
}
