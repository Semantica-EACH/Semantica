import 'package:flutter/material.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';

class Sidebar extends StatefulWidget {
  final List<ComponentView> components; // Lista de componentes minimizados
  final Function(ComponentView component) onMaximize; // Callback para maximizar
  final Function(ComponentView component)
      onExpand; // Callback para expandir no Sidebar

  const Sidebar({
    super.key,
    required this.components,
    required this.onMaximize,
    required this.onExpand,
  });

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
        itemCount: widget.components.length,
        itemBuilder: (context, index) {
          final component = widget.components[index];
          return component.renderSidebar(
            context,
            () => widget.onMaximize(component),
            () {}, // Fechar opcional
            () => _toggleExpand(component),
          );
        },
      ),
    );
  }
}
