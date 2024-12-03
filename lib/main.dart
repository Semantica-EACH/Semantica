import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/features/component/domain/usecases/close_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/maximize_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/minimize_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/open_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/redo_usecase.dart';
import 'package:semantica/features/component/domain/usecases/undo_usecase.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'package:semantica/features/component_list/domain/entities/central_stack.dart';
import 'package:semantica/features/component_list/domain/entities/side_list.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ComponentCubit>(
          create: (context) => ComponentCubit(
            maximizeUseCase: MaximizeComponentUseCase(),
            minimizeUseCase: MinimizeComponentUseCase(),
            openComponentUseCase: OpenComponentUseCase(),
            closeUseCase: CloseComponentUseCase(),
            sideList: SideList(),
            centralStack: CentralStack(),
            undoUseCase: UndoUseCase(),
            redoUseCase: RedoUseCase(),
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Clean Architecture',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          brightness: Brightness.light,
        ).copyWith(
          primary: const Color(0xFFF5F5F5), // offwhite
          secondary: const Color(0xFFBDBDBD), // cinza claro
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE0E0E0), // cinza mais escuro que offwhite
          iconTheme: IconThemeData(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.grey,
          brightness: Brightness.dark,
        ).copyWith(
          primary: const Color(0xFF212121), // cinza bem escuro
          secondary: const Color(0xFF424242), // cinza um pouco menos escuro
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F0F0F), // preto
          iconTheme: IconThemeData(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
