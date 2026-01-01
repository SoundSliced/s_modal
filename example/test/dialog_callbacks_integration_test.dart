import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
// integration_test isn't required for this widget-style test; use the
// default TestWidgets binding so the test runs with `flutter test`.
import 'package:s_modal_example/main.dart' as app;
import 'package:s_modal/s_modal.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    // Initialize the activator to ensure controllers are ready
    Modal.initialiseActivator();
  });

  tearDown(() {
    // Clean up all modals and dispose activator after each test
    Modal.dismissAll();
    Modal.dismissAllSnackbars();
    Modal.disposeActivator();
  });

  testWidgets(
      'Dialog callbacks do not reactivate dialog and no barrier remains',
      (WidgetTester tester) async {
    // Launch the example app
    app.main();
    await tester.pumpAndSettle();

    // Open Callbacks dialog - scroll until visible first
    final callbacksChip = find.text('Callbacks');
    await tester.scrollUntilVisible(callbacksChip, -300);
    await tester.pumpAndSettle();
    expect(callbacksChip, findsOneWidget);
    await tester.tap(callbacksChip);
    await tester.pumpAndSettle();

    final showDialogButton = find.widgetWithText(ElevatedButton, 'SHOW DIALOG');
    await tester.scrollUntilVisible(showDialogButton, -300);
    await tester.pumpAndSettle();
    expect(showDialogButton, findsOneWidget);
    await tester.tap(showDialogButton);
    await tester.pumpAndSettle();

    // Dialog should be visible
    expect(find.text('Callbacks Demo'), findsOneWidget);

    // Tap close inside dialog (ensure visible first)
    final closeButton = find.widgetWithText(ElevatedButton, 'Close');
    await tester.scrollUntilVisible(closeButton.first, -200);
    await tester.pumpAndSettle();
    expect(closeButton, findsWidgets);
    await tester.tap(closeButton.first);

    // Allow dismissal animations + callback to run
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));

    // Dialog should NOT be active
    expect(Modal.isDialogActive, isFalse);

    // Snackbar should be active (onDismiss shows 'Modal dismissed!')
    expect(Modal.isSnackbarActive, isTrue);

    // Clear snackbars quickly to avoid long waiting in test
    Modal.dismissAllSnackbars();
    await tester.pumpAndSettle();

    // Ensure no modal is active and app is interactive
    expect(Modal.isActive, isFalse);

    // Try tapping a button on the page to ensure barrier isn't blocking
    final showSnackbarButton =
        find.widgetWithText(ElevatedButton, 'SHOW SNACKBAR');
    expect(showSnackbarButton, findsOneWidget);
    // Ensure the button is visible in the viewport before tapping
    await tester.scrollUntilVisible(showSnackbarButton, -300);
    await tester.pumpAndSettle();
    await tester.tap(showSnackbarButton);
    // Pump to allow snackbar to appear
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    // A snackbar should now be visible again
    expect(Modal.isSnackbarActive, isTrue);

    // Cleanup
    Modal.dismissAllSnackbars();
    await tester.pumpAndSettle();
  });

  testWidgets('Dialog can be shown and dismissed programmatically',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final callbacksChip = find.text('Callbacks');
    await tester.scrollUntilVisible(callbacksChip, -300);
    await tester.pumpAndSettle();
    await tester.tap(callbacksChip);
    await tester.pumpAndSettle();

    final showDialogButton = find.widgetWithText(ElevatedButton, 'SHOW DIALOG');
    await tester.scrollUntilVisible(showDialogButton, -300);
    await tester.pumpAndSettle();
    await tester.tap(showDialogButton);
    await tester.pumpAndSettle();

    // Ensure dialog content is visible
    expect(find.text('Callbacks Demo'), findsOneWidget);
    expect(Modal.isDialogActive, isTrue);

    // Dismiss programmatically
    Modal.dismissDialog();
    await tester.pumpAndSettle();

    // Dialog should be dismissed
    expect(Modal.isDialogActive, isFalse);

    // Cleanup any remaining snackbars
    Modal.dismissAllSnackbars();
    await tester.pumpAndSettle();
  });
}
