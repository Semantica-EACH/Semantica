import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';

class CentralArea extends StatelessWidget {
  final ComponentView? component;

  const CentralArea({super.key, this.component});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: BlocBuilder<ComponentCubit, ComponentCubitState>(
      builder: (context, state) {
        if (state is ComponentUpdated || state is ComponentOpened) {
          final centralComponent = state is ComponentUpdated
              ? state.centralComponent
              : (state as ComponentOpened).centralComponent;
          if (centralComponent == null) {
            // Quando a área central está vazia
            return Center(
              child: Text(
                'Nenhum componente carregado',
                style: TextStyle(fontSize: 20, color: Theme.of(context).colorScheme.onSurface),
              ),
            );
          }

          return _renderComponent(context, centralComponent!);
        }
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    )
    );
  }

  Widget _renderComponent(BuildContext context, ComponentView component) {


  return component.renderCentral(
    context,
    () {
      // Lógica de minimizar
      context.read<ComponentCubit>().minimize(component.component.title);
    },
    () {
      // Lógica de fechar
      context.read<ComponentCubit>().closeComponent(component.component.title);
    },
    () {
      // Lógica de abrir
      context.read<ComponentCubit>().open(component);
    },
  );
}
}
