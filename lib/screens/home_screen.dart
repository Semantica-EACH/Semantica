import 'package:flutter/material.dart';
import 'package:semantica/features/pages/domain/services/page_open.dart';
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

  void _toggleSidebar() {
    setState(() {
      _isSidebarVisible = !_isSidebarVisible;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void _showPageDialog() {
    showPageDialog(context, onSubmit: (filePathOrName, fileBytes) async {
      try {
        await openPageComponent(
          context: context,
          filePathOrName: filePathOrName,
          fileBytes: fileBytes,
        );
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
