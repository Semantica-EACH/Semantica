// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';

abstract class Component {
  final String title;
  final IconData icon;

  Component({
    required this.title,
    IconData? icon,
  }) : icon = icon ?? Icons.extension;

  ComponentView toComponentView();

  @override
  bool operator ==(Object other);

  @override
  int get hashCode;
}
