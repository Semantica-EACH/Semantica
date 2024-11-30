import 'package:flutter/material.dart';

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
        /*  IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Voltar')),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Avançar')),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Abrir Configurações')),
            );
          },
        ),
        */

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
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
