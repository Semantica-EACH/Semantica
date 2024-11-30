import 'package:flutter/material.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';

class CentralArea extends StatelessWidget {
  final ComponentView? component;

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

  Widget _renderComponent(BuildContext context, ComponentView component) {
    return component.renderCentral(
      context,
      () {
        // Lógica de minimizar (pode ser vazia ou definida por você)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Componente minimizado')),
        );
      },
      () {
        // Lógica de fechar (pode ser vazia ou definida por você)
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Componente fechado')),
        );
      },
    );
  }
}
