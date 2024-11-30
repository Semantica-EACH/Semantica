import 'package:flutter/material.dart';
import 'package:semantica/core/presentation/component.dart';
import 'package:semantica/features/pages/data/page_loader.dart';
import 'package:semantica/features/pages/data/page_repository_impl.dart';
import 'package:semantica/features/pages/domain/usecases/get_page_usecase.dart';
import 'package:semantica/features/pages/domain/usecases/save_page_usecase.dart';
import 'package:semantica/features/pages/presentation/widgets/page_widget.dart';
import 'package:semantica/widgets/central_area.dart';
import 'package:semantica/widgets/dialogs/page_dialog.dart';
//import 'package:semantica/widgets/sidebar.dart';
import 'package:semantica/widgets/custom_app_bar.dart'; // Importação da CustomAppBar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  // bool _isSidebarVisible = true;
  late final GetPageUseCase _getPageUseCase; // Instância do caso de uso
  late final SavePageContentUseCase _savePageContentUseCase;

  Component? _currentComponent;

// Instância do PageLoader
/*
  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
    });
  }
*/

  @override
  void initState() {
    super.initState();

    // Configurações para o caso de uso
    final pageLoader = PageLoader();
    final pageRepository = PageRepositoryImpl(pageLoader: pageLoader);
    _getPageUseCase = GetPageUseCase(repository: pageRepository);
    _savePageContentUseCase =
        SavePageContentUseCase(repository: pageRepository);
  }

  void _showPageDialog() {
    showPageDialog(context, onSubmit: (filePath) async {
      try {
        // Usa o caso de uso para carregar a entidade Page
        final page = await _getPageUseCase.call(filePath);

        // Converte a entidade Page em um componente de apresentação
        if (mounted) {
          setState(() {
            _currentComponent = PageWidget(
              page: page,
              savePageContentUseCase:
                  _savePageContentUseCase, // Ou o caso de uso correto
            ) as Component?;
          });
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
    return Scaffold(
      appBar: CustomAppBar(
        //       onToggleSidebar: _toggleSidebar,
        onShowPageDialog: _showPageDialog,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 5,
            child: CentralArea(component: _currentComponent),
          ),
          /*     if (_isSidebarVisible)
            const Expanded(
              flex: 2,
              child: Sidebar(),
            ),*/
        ],
      ),
    );
  }
}
