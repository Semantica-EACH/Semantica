import 'package:flutter_test/flutter_test.dart';
import 'package:semantica/features/component/presentation/cubit/component_cubit_states.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semantica/features/component_list/domain/entities/central_stack.dart';
import 'package:semantica/features/component_list/domain/entities/side_list.dart';

class MockSideList extends Mock implements SideList {}

class MockCentralStack extends Mock implements CentralStack {}

void main() {
  setUpAll(() {
    registerFallbackValue(MockSideList());
    registerFallbackValue(MockCentralStack());
  });

  group('ComponentState', () {
    test('ComponentInitial should be a subclass of ComponentState', () {
      expect(ComponentInitial(), isA<ComponentState>());
    });

    test('ComponentUpdated should be a subclass of ComponentState', () {
      final sideList = MockSideList();
      final centralStack = MockCentralStack();
      final state =
          ComponentUpdated(sideList: sideList, centralStack: centralStack);

      expect(state, isA<ComponentState>());
      expect(state.sideList, sideList);
      expect(state.centralStack, centralStack);
    });

    test('ComponentUpdated should handle null centralStack', () {
      final sideList = MockSideList();
      final state = ComponentUpdated(
          sideList: sideList, centralStack: MockCentralStack());

      expect(state, isA<ComponentState>());
      expect(state.sideList, sideList);
      expect(state.centralStack, isNull);
    });
  });
}
