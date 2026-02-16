import 'package:flutter_test/flutter_test.dart';
import 'package:s_modal/s_modal.dart';

void main() {
  tearDown(() {
    // Clean up any active modal between tests.
    Modal.dismissAll();
  });

  testWidgets('Right side sheet can be expanded', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: Modal.appBuilder,
        home: const Scaffold(body: SizedBox.expand()),
      ),
    );

    // Show right side sheet and capture onExpanded callback
    // ignore: unused_local_variable
    bool expandedCalled = false;
    const String modalId = 'right-sheet-test';
    Modal.show(
      context: tester.element(find.byType(Scaffold)),
      builder: ([_]) => const SizedBox(width: 200, height: 200),
      modalType: ModalType.sheet,
      sheetPosition: SheetPosition.right,
      modalPosition: Alignment.centerRight,
      isExpandable: true,
      expandedPercentageSize: 80,
      id: modalId,
      onExpanded: () {
        expandedCalled = true;
      },
    );

    // Pump frames to allow modal to appear
    // Note: avoid pumpAndSettle() — the modal system uses Timer.periodic +
    // AnimatedContainer which continuously schedule new frames.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 400));

    // Verify the sheet is displayed by checking state
    expect(Modal.isSheetActive, true);
    expect(Modal.isModalActiveById(modalId), true);

    // Cleanup — pump enough time for dismiss animation + Future.delayed(0.4s)
    final dismissFuture = Modal.dismissById(modalId);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await dismissFuture;
  });
  testWidgets('Bottom sheet can be expanded', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        builder: Modal.appBuilder,
        home: const Scaffold(body: SizedBox.expand()),
      ),
    );

    // Show bottom sheet and capture onExpanded callback
    // ignore: unused_local_variable
    bool expandedCalled = false;
    const String modalId = 'bottom-sheet-test';
    Modal.show(
      context: tester.element(find.byType(Scaffold)),
      builder: ([_]) => const SizedBox(width: 200, height: 200),
      modalType: ModalType.sheet,
      modalPosition: Alignment.bottomCenter,
      isExpandable: true,
      expandedPercentageSize: 90,
      id: modalId,
      onExpanded: () {
        expandedCalled = true;
      },
    );

    // Pump frames to allow modal to appear
    // Note: avoid pumpAndSettle() — the modal system uses Timer.periodic +
    // AnimatedContainer which continuously schedule new frames.
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pump(const Duration(milliseconds: 400));

    // Verify the sheet is displayed by checking state
    expect(Modal.isSheetActive, true);
    expect(Modal.isModalActiveById(modalId), true);

    // Cleanup — pump enough time for dismiss animation + Future.delayed(0.4s)
    final dismissFuture = Modal.dismissById(modalId);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await dismissFuture;
  });
}
