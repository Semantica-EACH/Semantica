// feature/presentation/widgets/component_manager.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';

class ComponentManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComponentCubit, ComponentCubitState>(
      builder: (context, state) {
        if (state is ComponentUpdated) {
          final sidebarComponents =
              state.sidebarComponents; // List<ComponentView>
          final centralComponent = state.centralComponent; // ComponentView?

          return Row(
            children: [
              // Barra lateral com componentes minimizados
              Container(
                width: 200,
                child: ListView(
                  children: sidebarComponents.map((componentView) {
                    return componentView.renderSidebar(
                      context,
                      () => context
                          .read<ComponentCubit>()
                          .maximize(componentView.component.title),
                      () => context
                          .read<ComponentCubit>()
                          .closeComponent(componentView.component.title),
                      () => context.read<ComponentCubit>().expandComponent(
                          componentView
                              .component.title), // Lógica para expandir
                    );
                  }).toList(),
                ),
              ),
              // Área central com o componente maximizado
              Expanded(
                child: centralComponent != null
                    ? centralComponent.renderCentral(
                        context,
                        () => context
                            .read<ComponentCubit>()
                            .minimize(centralComponent.component.title),
                        () => context
                            .read<ComponentCubit>()
                            .closeComponent(centralComponent.component.title),
                      )
                    : Center(child: Text("Nenhum componente maximizado")),
              ),
            ],
          );
        }

        // Estado inicial ou carregando
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
