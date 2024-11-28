import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: ListView(
        children: [
          ListTile(
            title: const Text('Componente 1'),
            leading: const Icon(Icons.pages),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Abrir Componente 1')),
              );
            },
          ),
          ListTile(
            title: const Text('Componente 2'),
            leading: const Icon(Icons.graphic_eq),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Abrir Componente 2')),
              );
            },
          ),
        ],
      ),
    );
  }
}
