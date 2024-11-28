import 'package:flutter/material.dart';
import 'package:semantica/core/component.dart';
import 'package:semantica/features/pages/data/page_loader.dart';
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
  bool _isSidebarVisible = true;

  Component? _currentComponent;

  final PageLoader _pageLoader = PageLoader(); // Instância do PageLoader

  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
    });
  }

  void _showPageDialog() {
    showPageDialog(context, onSubmit: (filePath) async {
      try {
        // Processar o arquivo selecionado
        final page = await _pageLoader.loadPage(filePath);
        setState(() {
          _currentComponent = page;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao carregar a página: $e')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onToggleSidebar: _toggleSidebar,
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
