import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/features/component/domain/usecases/close_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/maximize_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/minimize_component_usecase.dart';
import 'package:semantica/features/component/domain/usecases/open_component_usecase.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';
import 'package:semantica/features/component_list/domain/entities/central_stack.dart';
import 'package:semantica/features/component_list/domain/entities/side_list.dart';

import '../../../../mocks/component_mock.dart';

class MockOpenComponentUseCase extends Mock implements OpenComponentUseCase {}

class MockMaximizeComponentUseCase extends Mock
    implements MaximizeComponentUseCase {}

class MockMinimizeComponentUseCase extends Mock
    implements MinimizeComponentUseCase {}

class MockCloseComponentUseCase extends Mock implements CloseComponentUseCase {}

class MockSideList extends Mock implements SideList {}

class MockCentralStack extends Mock implements CentralStack {}

void main() {
  late ComponentCubit componentCubit;
  late MockOpenComponentUseCase mockOpenComponentUseCase;
  late MockMaximizeComponentUseCase mockMaximizeUseCase;
  late MockMinimizeComponentUseCase mockMinimizeUseCase;
  late MockCloseComponentUseCase mockCloseUseCase;
  late MockSideList mockSideList;
  late MockCentralStack mockCentralStack;

  setUp(() {
    mockOpenComponentUseCase = MockOpenComponentUseCase();
    mockMaximizeUseCase = MockMaximizeComponentUseCase();
    mockMinimizeUseCase = MockMinimizeComponentUseCase();
    mockCloseUseCase = MockCloseComponentUseCase();
    mockSideList = MockSideList();
    mockCentralStack = MockCentralStack();

    when(() => mockSideList.components).thenReturn([]);
    when(() => mockCentralStack.components).thenReturn([]);

    componentCubit = ComponentCubit(
      maximizeUseCase: mockMaximizeUseCase,
      minimizeUseCase: mockMinimizeUseCase,
      openComponentUseCase: mockOpenComponentUseCase,
      closeUseCase: mockCloseUseCase,
      sideList: mockSideList,
      centralStack: mockCentralStack,
    );
  });

  group('ComponentCubit', () {
    final component = TestComponent(title: 'Test Component');

    group('openComponent', () {
      blocTest<ComponentCubit, ComponentState>(
        'emits [ComponentUpdated] when openComponent is called',
        build: () => componentCubit,
        act: (cubit) => cubit.openComponent(component),
        expect: () => [
          isA<ComponentUpdated>(),
        ],
        verify: (_) {
          verify(() => mockOpenComponentUseCase.call(
              component: component, centralStack: mockCentralStack)).called(1);
        },
      );
    });

    group('maximizeComponent', () {
      blocTest<ComponentCubit, ComponentState>(
        'emits [ComponentUpdated] when maximizeComponent is called',
        build: () => componentCubit,
        act: (cubit) => cubit.maximizeComponent(component),
        expect: () => [
          isA<ComponentUpdated>(),
        ],
        verify: (_) {
          verify(() => mockMaximizeUseCase.call(
              component: component,
              sideList: mockSideList,
              centralStack: mockCentralStack)).called(1);
        },
      );
    });

    group('minimizeComponent', () {
      blocTest<ComponentCubit, ComponentState>(
        'emits [ComponentUpdated] when minimizeComponent is called',
        build: () => componentCubit,
        act: (cubit) => cubit.minimizeComponent(component),
        expect: () => [
          isA<ComponentUpdated>(),
        ],
        verify: (_) {
          verify(() => mockMinimizeUseCase.call(
              component: component,
              sideList: mockSideList,
              centralStack: mockCentralStack)).called(1);
        },
      );
    });

    group('closeComponent', () {
      blocTest<ComponentCubit, ComponentState>(
        'emits [ComponentUpdated] when closeComponent is called',
        build: () => componentCubit,
        act: (cubit) => cubit.closeComponent(component),
        expect: () => [
          isA<ComponentUpdated>(),
        ],
        verify: (_) {
          verify(() => mockCloseUseCase.call(
              component: component, componentList: mockSideList)).called(1);
          verify(() => mockCloseUseCase.call(
              component: component, componentList: mockCentralStack)).called(1);
        },
      );
    });
  });
}
