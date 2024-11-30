import 'package:flutter/material.dart';

abstract class Component {
  /// Renderiza na área central
  Widget renderCentral(BuildContext context);

  /// Renderiza na área lateral
  Widget renderSidebar(BuildContext context);
}
