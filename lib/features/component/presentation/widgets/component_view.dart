// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:semantica/features/component/domain/entities/component.dart';

// ignore: must_be_immutable
abstract class ComponentView extends StatelessWidget {
  Component get component;
  bool isExpanded = false;

  ComponentView({
    super.key,
    required this.isExpanded,
  });

  /// Método para renderizar o conteúdo específico no `renderCentral`
  Widget renderCentralContent(BuildContext context);

  /// Método para renderizar o conteúdo específico no `renderSidebar`
  Widget renderSidebarContent(BuildContext context);

  /// Renderiza a área central com os botões no canto superior direito
  Widget renderCentral(
      BuildContext context, VoidCallback onMinimize, VoidCallback onClose, VoidCallback onOpen) {
    return Column(
      children: [
        // Barra superior com os botões de minimizar e fechar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(), // Espaço vazio no canto esquerdo
              Row(
                children: [
                  IconButton(
                    onPressed: onMinimize,
                    icon: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: onClose,
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Renderização delegada para a subclasse
        Expanded(
          child: renderCentralContent(context),
        ),
      ],
    );
  }

  /// Renderiza um Tile individual no Sidebar
  Widget renderSidebar(BuildContext context, VoidCallback onMaximize,
      VoidCallback onClose, VoidCallback onExpand) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Cabeçalho do tile
        GestureDetector(
          onTap: onExpand, // Alterna entre expandir e colapsar
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    component.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: onExpand,
                      icon: Icon(
                        isExpanded ? Icons.expand_less : Icons.expand_more,
                      ),
                    ),
                    IconButton(
                      onPressed: onMaximize,
                      icon: const Icon(Icons.open_in_full),
                    ),
                    IconButton(
                      onPressed: onClose,
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Conteúdo expandido
        if (isExpanded)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: renderSidebarContent(context),
          ),
      ],
    );
  }
}
