import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:semantica/features/component/domain/usecases/close_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/maximize_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/minimize_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/open_component.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
  BlocProvider(
      create: (_) => ComponentCubit(
        initialSidebarComponents: [],
        maximizeUseCase: MaximizeComponentUseCase(),
        minimizeUseCase: MinimizeComponentUseCase(),
        closeUseCase: CloseComponentUseCase(),
        openComponentUseCase: OpenComponentUseCase()
      ),
      child: const MyApp(),
    ),
  );  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      debugShowCheckedModeBanner: false,
      title: 'Flutter Clean Architecture',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[900],
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
