import 'package:flutter/material.dart';
import 'package:semantica/core/presentation/component.dart';

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
          : _renderComponent(context, component!),
    );
  }

  Widget _renderComponent(BuildContext context, Component component) {
    return component
        .renderCentral(context); // Passa o BuildContext para o método render
  }
}
