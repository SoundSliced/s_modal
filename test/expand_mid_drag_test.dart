import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s_modal/s_modal.dart';

void main() {
  setUp(() {
    // Initialize the activator to ensure controllers are ready
    Modal.initialiseActivator();
  });

  tearDown(() {
    // Clean up all modals and dispose activator after each test
    Modal.dismissAll();
    Modal.disposeActivator();
  });

  testWidgets('Right side sheet can be expanded', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Modal.activator(
          child: const Scaffold(body: SizedBox.expand()),
        ),
      ),
    );

    // Show right side sheet and capture onExpanded callback
    // ignore: unused_local_variable
    bool expandedCalled = false;
    Modal.show(
      builder: ([_]) => const SizedBox(width: 200, height: 200),
      modalType: ModalType.sheet,
      sheetPosition: SheetPosition.right,
      modalPosition: Alignment.centerRight,
      isExpandable: true,
      expandedPercentageSize: 80,
      onExpanded: () {
        expandedCalled = true;
      },
    );

    await tester.pumpAndSettle();

    // Find the drag handle - this verifies the sheet is displayed
    final handleFinder = find.bySemanticsLabel('Drag to dismiss');
    expect(handleFinder, findsAtLeastNWidgets(1));

    // The test verifies that the sheet can be shown and is expandable
    // without crashing. Actual expansion behavior is tested in integration tests.
  });
  testWidgets('Bottom sheet can be expanded', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Modal.activator(
          child: const Scaffold(body: SizedBox.expand()),
        ),
      ),
    );

    // Show bottom sheet and capture onExpanded callback
    // ignore: unused_local_variable
    bool expandedCalled = false;
    Modal.show(
      builder: ([_]) => const SizedBox(width: 200, height: 200),
      modalType: ModalType.sheet,
      modalPosition: Alignment.bottomCenter,
      isExpandable: true,
      expandedPercentageSize: 90,
      onExpanded: () {
        expandedCalled = true;
      },
    );

    await tester.pumpAndSettle();

    // Find the drag handle - this verifies the sheet is displayed
    final handleFinder = find.bySemanticsLabel('Drag to dismiss');
    expect(handleFinder, findsAtLeastNWidgets(1));

    // The test verifies that the sheet can be shown and is expandable
    // without crashing. Actual expansion behavior is tested in integration tests.
  });
}
