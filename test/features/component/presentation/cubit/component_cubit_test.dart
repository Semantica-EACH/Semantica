import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';
import 'package:semantica/features/component_collection/domain/entities/central_stack.dart';
import 'package:semantica/features/component_collection/domain/entities/side_list.dart';
import 'package:semantica/features/component/domain/usecases/component_manager.dart';
import 'package:semantica/features/component/domain/usecases/history_manager.dart';

import '../../../../mocks/component_mock.dart';

class MockSideList extends Mock implements SideList {}

class MockCentralStack extends Mock implements CentralStack {}

class MockComponentManager extends Mock implements ComponentManager {}

class MockHistoryManager extends Mock implements HistoryManager {}

void main() {
  setUpAll(() {
    registerFallbackValue(MockCentralStack());
  });
  late ComponentCubit componentCubit;
  late MockSideList mockSideList;
  late MockCentralStack mockCentralStack;
  late MockComponentManager mockComponentManager;
  late MockHistoryManager mockHistoryManager;

  setUp(() {
    mockSideList = MockSideList();
    mockCentralStack = MockCentralStack();
    mockComponentManager = MockComponentManager();
    mockHistoryManager = MockHistoryManager();

    when(() => mockSideList.components).thenReturn([]);
    when(() => mockCentralStack.components).thenReturn([]);

    componentCubit = ComponentCubit(
      componentManager: mockComponentManager,
      historyManager: mockHistoryManager,
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
          verify(() => mockComponentManager.openComponent(
              component: component,
              componentCollection: mockCentralStack)).called(1);
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
          verify(() => mockComponentManager.maximizeComponent(
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
          verify(() => mockComponentManager.minimizeComponent(
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
          verify(() => mockComponentManager.closeComponent(
              component: component,
              componentCollection: mockSideList)).called(1);
          verify(() => mockComponentManager.closeComponent(
              component: component,
              componentCollection: mockCentralStack)).called(1);
        },
      );
    });

    test('should call undoUseCase and emit ComponentUpdated on undo', () {
      when(() => mockHistoryManager.undo(any())).thenAnswer((_) async {});

      componentCubit.undo();

      verify(() => mockHistoryManager.undo(mockCentralStack)).called(1);
      expect(componentCubit.state, isA<ComponentUpdated>());
    });

    test('should call redoUseCase and emit ComponentUpdated on redo', () {
      when(() => mockHistoryManager.redo(any())).thenAnswer((_) async {});

      componentCubit.redo();

      verify(() => mockHistoryManager.redo(mockCentralStack)).called(1);
      expect(componentCubit.state, isA<ComponentUpdated>());
    });
  });
}
