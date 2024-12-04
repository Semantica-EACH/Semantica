import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:semantica/features/component/presentation/widgets/component_view.dart';

import '../../../../mocks/component_mock.dart';

// ignore: must_be_immutable
class TestComponentView extends ComponentView {
  TestComponentView({super.key, required super.component});

  @override
  Widget renderCentralContent(BuildContext context) {
    return Container();
  }

  @override
  Widget renderSidebarContent(BuildContext context) {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        renderCentralContent(context),
        renderSidebarContent(context),
      ],
    );
  }
}

void main() {
  group('ComponentView', () {
    testWidgets('should create ComponentView with required component',
        (WidgetTester tester) async {
      final component = TestComponent(title: 'Test Component');
      final widget = TestComponentView(component: component);

      await tester.pumpWidget(MaterialApp(home: widget));

      expect(widget.component, equals(component));
    });
  });
}
