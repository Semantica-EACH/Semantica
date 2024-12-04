import 'package:bloc/bloc.dart';
import 'package:semantica/features/component_collection/domain/entities/central_stack.dart';
import 'package:semantica/features/component_collection/presentation/cubit/navigation_cubit_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  final CentralStack centralStack;

  NavigationCubit({required this.centralStack}) : super(NavigationInitial());
}
