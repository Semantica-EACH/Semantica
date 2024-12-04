import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';

class CentralArea extends StatefulWidget {
  const CentralArea({super.key});

  @override
  CentralAreaState createState() => CentralAreaState();
}

class CentralAreaState extends State<CentralArea> {
  ComponentView? centralComponent;

  @override
  void initState() {
    super.initState();
    centralComponent = null;
  }

  void updateComponent(ComponentView newComponent) {
    setState(() {
      centralComponent = newComponent;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComponentCubit, ComponentState>(
      builder: (context, state) {
        return BlocListener<ComponentCubit, ComponentState>(
          listener: (context, state) {
            if (state is ComponentUpdated) {
              setState(() {
                centralComponent = state.centralStack
                    ?.getCurrentComponent()
                    ?.toComponentView();
              });
            }
          },
          child: Container(
            color: Theme.of(context).colorScheme.primary,
            child: centralComponent == null
                ? Container()
                : _renderComponent(context, centralComponent!),
          ),
        );
      },
    );
  }

  Widget _renderComponent(BuildContext context, ComponentView component) {
    return Column(
      children: [
        // Barra superior com os botões de minimizar e fechar
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context
                          .read<ComponentCubit>()
                          .minimizeComponent(component.component);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      context
                          .read<ComponentCubit>()
                          .closeComponent(component.component);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: component.renderCentralContent(context),
        ),
      ],
    );
  }
}
