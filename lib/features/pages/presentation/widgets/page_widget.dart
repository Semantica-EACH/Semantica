import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/features/block/presentation/widgets/block_widget.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';
import 'package:semantica/features/pages/data/page_loader.dart';
import 'package:semantica/features/pages/data/page_repository_impl.dart';
import 'package:semantica/features/pages/domain/entities/page.dart' as my_page;
import 'package:semantica/features/pages/domain/usecases/save_page_usecase.dart';
import 'package:semantica/features/pages/presentation/cubit/page_cubit.dart';

// ignore: must_be_immutable
class PageWidget extends ComponentView {
  @override
  final my_page.Page component;

  PageWidget({super.key, required this.component})
      : super(component: component);

  @override
  Widget build(BuildContext context) {
    final pageLoader = PageLoader();
    final pageRepository = PageRepositoryImpl(pageLoader: pageLoader);
    final savePageContentUseCase =
        SavePageContentUseCase(repository: pageRepository);

    return BlocProvider(
      create: (_) => PageCubit(
        context,
        page: component,
        savePageContentUseCase: savePageContentUseCase,
      ),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: BlockWidget(
                            block: component.content,
                            page: component,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
