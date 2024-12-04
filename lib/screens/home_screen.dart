import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'package:semantica/features/pages/data/page_loader.dart';
import 'package:semantica/features/pages/data/page_repository_impl.dart';
import 'package:semantica/features/pages/domain/usecases/get_page_from_byte.dart';
import 'package:semantica/features/pages/domain/usecases/get_page_usecase.dart';
import 'package:semantica/features/pages/domain/usecases/save_page_usecase.dart';
import 'package:semantica/features/pages/presentation/widgets/page_widget.dart';
import 'package:semantica/features/component_collection/presentation/widgets/central_area.dart';
import 'package:semantica/widgets/dialogs/page_dialog.dart';
import 'package:semantica/features/component_collection/presentation/widgets/sidebar.dart';
import 'package:semantica/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool _isSidebarVisible = true;
  late final GetPageUseCase _getPageUseCase;
  late final GetPageFromBytesUseCase _getPageFromBytesUseCase;
  late final SavePageContentUseCase _savePageContentUseCase;

// Componentes no Sidebar

  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    final pageLoader = PageLoader();
    final pageRepository = PageRepositoryImpl(pageLoader: pageLoader);
    _getPageUseCase = GetPageUseCase(repository: pageRepository);
    _getPageFromBytesUseCase =
        GetPageFromBytesUseCase(repository: pageRepository);
    _savePageContentUseCase =
        SavePageContentUseCase(repository: pageRepository);
  }

  void _showPageDialog() {
    showPageDialog(context, onSubmit: (filePathOrName, fileBytes) async {
      try {
        final page = fileBytes != null
            ? await _getPageFromBytesUseCase.call(fileBytes, filePathOrName)
            : await _getPageUseCase.call(filePathOrName);

        final newComponent = PageWidget(
          component: page,
          savePageContentUseCase: _savePageContentUseCase,
        );

        if (mounted) {
          context.read<ComponentCubit>().openComponent(page);
          final centralAreaState =
              context.findAncestorStateOfType<CentralAreaState>();
          centralAreaState?.updateComponent(newComponent);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao carregar a página: $e')),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        onToggleSidebar: _toggleSidebar,
        onShowPageDialog: _showPageDialog,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              color: theme.colorScheme.primary,
              child: const CentralArea(),
            ),
          ),
          if (_isSidebarVisible)
            Expanded(
              flex: 2,
              child: Container(
                color: theme.colorScheme.secondary,
                child: const Sidebar(),
              ),
            ),
        ],
      ),
    );
  }
}
