import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';
import 'package:semantica/screens/configurations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onToggleSidebar;
  final VoidCallback onShowPageDialog;

  const CustomAppBar({
    super.key,
    required this.onToggleSidebar,
    required this.onShowPageDialog,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComponentCubit, ComponentState>(
        builder: (context, state) {
      final componentCubit = context.read<ComponentCubit>();
      final isFirst = componentCubit.isFirst();
      final isLast = componentCubit.isLast();

      return AppBar(
        /* title: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navegar para Home')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Busca ativada')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.hub),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Acessar Grafo')),
              );
            },
          ),
        ],
      ), */
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: isFirst ? null : componentCubit.undo,
            color: isFirst ? Colors.grey : null,
            tooltip: isFirst ? 'No previous component' : 'Undo',
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: isLast ? null : componentCubit.redo,
            color: isLast ? Colors.grey : null,
            tooltip: isLast ? 'No next component' : 'Redo',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const ConfigurationsModal();
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.file_open),
            onPressed: onShowPageDialog,
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: onToggleSidebar,
          ),
        ],
      );
    });
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
