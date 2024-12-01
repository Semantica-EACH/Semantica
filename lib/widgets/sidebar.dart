import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  // Alterna o estado de expansão para o componente clicado
  void _toggleExpand(ComponentView component) {
    setState(() {
      component.isExpanded = !component.isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComponentCubit, ComponentCubitState>(
      builder: (context, state) {
        if (state is ComponentUpdated) {
          final components = state.sidebarComponents;
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondaryContainer,
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: ListView.builder(
              itemCount: components.length,
              itemBuilder: (context, index) {
                final component = components[index];
                return component.renderSidebar(
                  context,
                  () => context.read<ComponentCubit>().maximize(component.component.title),
                  () => context.read<ComponentCubit>().closeComponent(component.component.title),
                  () => _toggleExpand(component),
                );
              },
            ),
          );
        }
        return const SizedBox.shrink(); // Exibe nada enquanto não houver estado
      },
    );
  }
}

