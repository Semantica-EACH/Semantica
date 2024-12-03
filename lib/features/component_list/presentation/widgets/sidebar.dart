import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/features/component/domain/entities/component.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';

class Sidebar extends StatefulWidget {
  const Sidebar({super.key});

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  final Map<Component, bool> _expandedComponents = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: BlocBuilder<ComponentCubit, ComponentState>(
        builder: (context, state) {
          if (state is ComponentUpdated) {
            return ListView(
              children: state.sidebarComponents.map((component) {
                final componentView = component.toComponentView();
                final isExpanded = _expandedComponents[component] ?? false;

                return Column(
                  children: [
                    ListTile(
                      title: Text(component.title),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            iconSize: 16.0,
                            icon: Icon(isExpanded
                                ? Icons.expand_less
                                : Icons.expand_more),
                            onPressed: () {
                              setState(() {
                                _expandedComponents[component] = !isExpanded;
                              });
                            },
                          ),
                          IconButton(
                            iconSize: 16.0,
                            icon: const Icon(Icons.open_in_full),
                            onPressed: () {
                              context
                                  .read<ComponentCubit>()
                                  .maximizeComponent(component);
                            },
                          ),
                          IconButton(
                            iconSize: 16.0,
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              context
                                  .read<ComponentCubit>()
                                  .closeComponent(component);
                            },
                          ),
                        ],
                      ),
                    ),
                    if (isExpanded) componentView.renderSidebarContent(context),
                  ],
                );
              }).toList(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
