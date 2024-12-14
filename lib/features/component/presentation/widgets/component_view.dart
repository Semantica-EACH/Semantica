// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:semantica/features/component/domain/entities/component.dart';

// ignore: must_be_immutable
abstract class ComponentView extends StatelessWidget {
  final Component component;
  bool isExpanded = false;

  ComponentView({
    super.key,
    required this.component,
  });

  Component toComponent() {
    return component;
  }

  /// Método para renderizar o conteúdo específico no `renderCentral`
  Widget renderCentralContent(BuildContext context) {
    return this;
  }

  /// Método para renderizar o conteúdo específico no `renderSidebar`
  Widget renderSidebarContent(BuildContext context) {
    return this;
  }
}
