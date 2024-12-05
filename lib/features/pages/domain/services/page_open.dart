import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:typed_data';

import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'package:semantica/features/component_collection/presentation/widgets/central_area.dart';
import 'package:semantica/features/pages/data/page_loader.dart';
import 'package:semantica/features/pages/data/page_repository_impl.dart';
import 'package:semantica/features/pages/domain/usecases/get_page_from_byte.dart';
import 'package:semantica/features/pages/domain/usecases/get_page_usecase.dart';
import 'package:semantica/features/pages/domain/usecases/save_page_usecase.dart';
import 'package:semantica/features/pages/presentation/widgets/page_widget.dart';

Future<void> openPageComponent({
  required BuildContext context,
  required String filePathOrName,
  Uint8List? fileBytes,
}) async {
  final pageLoader = PageLoader();
  final pageRepository = PageRepositoryImpl(pageLoader: pageLoader);
  var getPageUseCase = GetPageUseCase(repository: pageRepository);
  var getPageFromBytesUseCase =
      GetPageFromBytesUseCase(repository: pageRepository);
  var savePageContentUseCase =
      SavePageContentUseCase(repository: pageRepository);

  final page = fileBytes != null
      ? await getPageFromBytesUseCase.call(fileBytes, filePathOrName)
      : await getPageUseCase.call(filePathOrName);

  final newComponent = PageWidget(
    component: page,
    savePageContentUseCase: savePageContentUseCase,
  );

  if (context.mounted) {
    context.read<ComponentCubit>().openComponent(page);
    final centralAreaState =
        context.findAncestorStateOfType<CentralAreaState>();
    centralAreaState?.updateComponent(newComponent);
  }
}
