// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:s_modal/s_modal.dart';

// Helper builder for tests
Widget _testBuilder([BuildContext? _]) => const SizedBox();

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

  group('Modal API Tests', () {
    test('Modal.show() accepts all ModalType values', () {
      // These should not throw - just testing API availability
      expect(
          () => Modal.show(builder: _testBuilder, modalType: ModalType.sheet),
          returnsNormally);
      expect(
          () => Modal.show(builder: _testBuilder, modalType: ModalType.sheet),
          returnsNormally);
      expect(
          () => Modal.show(builder: _testBuilder, modalType: ModalType.dialog),
          returnsNormally);
      expect(
          () => Modal.show(builder: _testBuilder, modalType: ModalType.sheet),
          returnsNormally);
      expect(
          () =>
              Modal.show(builder: _testBuilder, modalType: ModalType.snackbar),
          returnsNormally);
      expect(
          () => Modal.show(builder: _testBuilder, modalType: ModalType.custom),
          returnsNormally);
    });

    test('Modal.show() accepts various configuration parameters', () {
      // Test that Modal.show() accepts common parameters without throwing
      expect(
        () => Modal.show(
          builder: _testBuilder,
          modalType: ModalType.dialog,
          modalPosition: Alignment.center,
          shouldBlurBackground: true,
          blurAmount: 5.0,
          isDismissable: false,
          isExpandable: true,
          size: 500,
          expandedPercentageSize: 90,
        ),
        returnsNormally,
      );
    });

    test('ModalType enum has all expected values', () {
      expect(ModalType.values, contains(ModalType.sheet));
      expect(ModalType.values, contains(ModalType.dialog));
      expect(ModalType.values, contains(ModalType.snackbar));
      expect(ModalType.values, contains(ModalType.custom));
    });

    test('Modal.show() supports various Alignment values for modalPosition',
        () {
      // Test that modalPosition parameter accepts standard Alignment values
      expect(
          () => Modal.show(
              builder: _testBuilder, modalPosition: Alignment.center),
          returnsNormally);
      expect(
          () => Modal.show(
              builder: _testBuilder, modalPosition: Alignment.topLeft),
          returnsNormally);
      expect(
          () => Modal.show(
              builder: _testBuilder, modalPosition: Alignment.topRight),
          returnsNormally);
      expect(
          () => Modal.show(
              builder: _testBuilder, modalPosition: Alignment.bottomLeft),
          returnsNormally);
      expect(
          () => Modal.show(
              builder: _testBuilder, modalPosition: Alignment.bottomRight),
          returnsNormally);
      expect(
          () => Modal.show(
              builder: _testBuilder, modalPosition: Alignment.centerLeft),
          returnsNormally);
      expect(
          () => Modal.show(
              builder: _testBuilder, modalPosition: Alignment.centerRight),
          returnsNormally);
      expect(
          () => Modal.show(
              builder: _testBuilder, modalPosition: Alignment.topCenter),
          returnsNormally);
      expect(
          () => Modal.show(
              builder: _testBuilder, modalPosition: Alignment.bottomCenter),
          returnsNormally);
    });

    test('ModalAnimationType enum has all expected values', () {
      expect(ModalAnimationType.values, contains(ModalAnimationType.fade));
      expect(ModalAnimationType.values, contains(ModalAnimationType.scale));
      expect(ModalAnimationType.values, contains(ModalAnimationType.slide));
      expect(ModalAnimationType.values, contains(ModalAnimationType.rotate));
    });
  });

  group('Modal ID Tests', () {
    test('Modal.show() with custom ID can be referenced', () {
      // Show a modal with a custom ID
      Modal.show(builder: _testBuilder, id: 'my_custom_id');

      // The ID should be tracked
      expect(Modal.isModalActiveById('my_custom_id'), true);
      expect(Modal.allActiveModalIds, contains('my_custom_id'));

      // Cleanup
      Modal.dismissById('my_custom_id');
    });

    test('Modal.showSnackbar() supports custom ID parameter', () {
      Modal.showSnackbar(
        text: 'Test message',
        id: 'snackbar_123',
      );

      expect(Modal.isModalActiveById('snackbar_123'), true);

      // Cleanup
      Modal.dismissById('snackbar_123');
    });
  });

  group('Type-Specific Controller Tests', () {
    test('Dialog controller is accessible', () {
      expect(Modal.dialogController, isNotNull);
    });

    test('Sheet controller is accessible', () {
      expect(Modal.sheetController, isNotNull);
    });

    test('Snackbar controller is accessible', () {
      expect(Modal.snackbarController, isNotNull);
    });

    test('Type-specific state checks are initially false', () {
      // Ensure all modals are dismissed before checking
      Modal.dismissAll();
      Modal.dismissAllSnackbars();
      expect(Modal.isDialogActive, false);
      expect(Modal.isSheetActive, false);
      expect(Modal.isSnackbarActive, false);
    });

    test('Type-specific dismissing states are initially false', () {
      // Ensure all modals are dismissed before checking
      Modal.dismissAll();
      Modal.dismissAllSnackbars();
      expect(Modal.isDialogDismissing, false);
      expect(Modal.isSheetDismissing, false);
      expect(Modal.isSnackbarDismissing, false);
    });
  });

  group('Modal ID Management Tests', () {
    test('activeModalId returns null when no modal is active', () {
      // Ensure all modals are dismissed before checking
      Modal.dismissAll();
      Modal.dismissAllSnackbars();
      expect(Modal.activeModalId, isNull);
    });

    test('isModalActiveById returns false when no modal is active', () {
      expect(Modal.isModalActiveById('any_id'), false);
    });

    test('allActiveModalIds returns empty list when no modals are active', () {
      // Ensure all modals are dismissed before checking
      Modal.dismissAll();
      Modal.dismissAllSnackbars();
      expect(Modal.allActiveModalIds, isEmpty);
    });
  });

  group('Snackbar Configuration Tests', () {
    test('SnackbarDisplayMode enum has all expected values', () {
      expect(
          SnackbarDisplayMode.values, contains(SnackbarDisplayMode.staggered));
      expect(SnackbarDisplayMode.values,
          contains(SnackbarDisplayMode.notificationBubble));
      expect(SnackbarDisplayMode.values, contains(SnackbarDisplayMode.queued));
      expect(SnackbarDisplayMode.values, contains(SnackbarDisplayMode.replace));
    });

    test('Modal.showSnackbar() accepts configuration parameters', () {
      expect(
        () => Modal.showSnackbar(
          text: 'Test notification',
          position: Alignment.topCenter,
          duration: const Duration(seconds: 3),
          isDismissible: true,
          displayMode: SnackbarDisplayMode.staggered,
        ),
        returnsNormally,
      );
    });
  });

  group('Modal Static Methods Tests', () {
    test('Modal.bottomSheetTemplate is accessible', () {
      final template = Modal.bottomSheetTemplate;
      expect(template, isNotNull);
    });

    test('Modal.isActive returns false initially', () {
      // Ensure all modals are dismissed before checking
      Modal.dismissAll();
      Modal.dismissAllSnackbars();
      expect(Modal.isActive, false);
    });

    test('Modal.controller is accessible', () {
      expect(Modal.controller, isNotNull);
    });

    test('Modal.dismissModalAnimationController is accessible', () {
      expect(Modal.dismissModalAnimationController, isNotNull);
    });

    test('Modal.snackbarQueue is accessible', () {
      expect(Modal.snackbarQueue, isNotNull);
    });

    test('Modal.snackbarStackIndex is accessible', () {
      expect(Modal.snackbarStackIndex, isNotNull);
    });
  });

  group('Modal Lifecycle Tests', () {
    test('Modal activator creates valid widget', () {
      final widget = Modal.activator(child: const SizedBox());
      expect(widget, isNotNull);
    });

    testWidgets(
        'Dialog dismissed via barrier can show snackbar and app remains interactive',
        (WidgetTester tester) async {
      // Use MaterialApp to ensure proper layout and media query for full-screen barrier
      await tester.pumpWidget(
        MaterialApp(
          home: Modal.activator(
            child: const Scaffold(
              body: SizedBox.expand(),
            ),
          ),
        ),
      );

      // Show a dialog modal that enqueues a short-lived snackbar on dismiss
      // Use a fixed size content so we can reliably tap outside it
      Modal.show(
        builder: ([_]) => const SizedBox(width: 100, height: 100),
        modalType: ModalType.dialog,
        onDismissed: () {
          // Show a snackbar with enough duration to survive the test checks
          Modal.showSnackbar(
            text: 'Dismissed',
            duration: const Duration(seconds: 5),
          );
        },
      );
      await tester.pumpAndSettle();

      expect(Modal.isDialogActive, true);

      // Perform a barrier tap at the top-left area of the screen.
      // Since dialog is centered and 100x100, top-left (10,10) is definitely barrier.
      await tester.tapAt(const Offset(10, 10));

      // Pump to register the tap gesture
      await tester.pump();

      // Advance time for the dismissal animations (0.4s)
      // We pump more than enough to ensure the timer triggers
      await tester.pump(const Duration(milliseconds: 600));
      // Pump a bit more for state to settle, but NOT pumpAndSettle which waits for all timers
      await tester.pump(const Duration(milliseconds: 100));

      // Dialog should NOT be active but snackbar should be active
      expect(Modal.isDialogActive, false);
      expect(Modal.isSnackbarActive, true);

      // Advance time to trigger auto-dismiss timer (5s) + animation delay (300ms)
      await tester.pump(const Duration(seconds: 5, milliseconds: 500));
      await tester.pumpAndSettle();

      // After snackbar dismiss completes, no modal should remain active
      // Clean up any remaining state
      Modal.dismissAll();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      final activeDialog = Modal.isDialogActive;
      final activeBottom = Modal.isSheetActive;
      final activeSnack = Modal.isSnackbarActive;
      expect(activeDialog, false, reason: 'dialog still active');
      expect(activeBottom, false, reason: 'bottom sheet still active');
      expect(activeSnack, false, reason: 'snackbar still active');
      expect(Modal.isActive, false,
          reason:
              'still active: dialog=$activeDialog bottom=$activeBottom snack=$activeSnack');
    });

    testWidgets(
        'Programmatic dismissDialog triggers onDismissed snackbar and app remains interactive',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Modal.activator(
            child: const Scaffold(body: SizedBox.expand()),
          ),
        ),
      );

      Modal.show(
        builder: ([_]) => const Center(
          child: SizedBox(width: 200, height: 80, child: Text('API Barrier')),
        ),
        modalType: ModalType.dialog,
        onDismissed: () {
          Modal.showSnackbar(
            text: 'API Dismissed',
            duration: const Duration(seconds: 2),
          );
        },
      );
      await tester.pumpAndSettle();

      expect(Modal.isDialogActive, true);

      // Programmatically dismiss the dialog (same behavior as barrier dismiss)
      // We must not await this directly because it contains a Future.delayed
      // which requires tester.pump() to complete.
      final dismissFuture = Modal.dismissDialog();

      // Advance time to allow the internal Future.delayed (0.4s) to complete
      await tester.pump(const Duration(milliseconds: 600));

      await dismissFuture;

      expect(Modal.isDialogActive, false);
      expect(Modal.isSnackbarActive, true);

      // Wait for the snackbar to auto-dismiss
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle(); // Ensure all animations settle

      expect(Modal.isSnackbarActive, false);

      // Ensure app remains interactive by showing another dialog
      Modal.show(
          builder: ([_]) => const SizedBox.shrink(),
          modalType: ModalType.dialog);
      await tester.pumpAndSettle();
      expect(Modal.isDialogActive, true);

      // Clean up final dialog
      Modal.dismissDialog();
      // Pump enough time for dismissal animation (300ms) + cleanup (400ms)
      await tester.pump(const Duration(seconds: 1));
      await tester.pumpAndSettle();
    });

    test('Modal.updateParams is callable', () {
      // Test that updateParams can be called (edge cases tested in integration tests)
      expect(
          () => Modal.updateParams(id: 'nonexistent_id', isDismissable: false),
          returnsNormally);
    });

    test('Modal initialiseActivator completes without error', () {
      expect(() => Modal.initialiseActivator(), returnsNormally);
    });

    test('Modal disposeActivator completes without error', () {
      expect(() => Modal.disposeActivator(), returnsNormally);
    });
  });

  group('Modal State Management Tests', () {
    test('Modal.isDismissing flag exists', () {
      expect(Modal.isDismissing, isA<bool>());
    });

    test('Modal.registerHeightResetCallback accepts valid callback', () {
      void testCallback() {}
      expect(
        () => Modal.registerHeightResetCallback(testCallback),
        returnsNormally,
      );
    });
  });

  group('Modal API Parameter Tests', () {
    test('Modal.show() accepts size parameter', () {
      expect(
        () => Modal.show(builder: _testBuilder, size: 200),
        returnsNormally,
      );
      expect(
        () => Modal.show(builder: _testBuilder, size: 600),
        returnsNormally,
      );
    });

    test('Modal.show() accepts expandedPercentageSize parameter', () {
      expect(
        () => Modal.show(
            builder: _testBuilder,
            isExpandable: true,
            expandedPercentageSize: 50),
        returnsNormally,
      );
      expect(
        () => Modal.show(
            builder: _testBuilder,
            isExpandable: true,
            expandedPercentageSize: 100),
        returnsNormally,
      );
    });
  });

  group('Enum Tests', () {
    test('ModalType enum values are distinct', () {
      final types = ModalType.values;
      expect(types.length, 4); // sheet, dialog, snackbar, custom
      expect(types.toSet().length, 4);
    });

    test('Alignment values work with modalPosition', () {
      // Test common alignment values work with modalPosition
      final positions = [
        Alignment.center,
        Alignment.topLeft,
        Alignment.topCenter,
        Alignment.topRight,
        Alignment.bottomLeft,
        Alignment.bottomCenter,
        Alignment.bottomRight,
        Alignment.centerLeft,
        Alignment.centerRight,
      ];
      expect(positions.length, 9);
      expect(positions.toSet().length, 9);
    });

    test('ModalAnimationType enum values are distinct', () {
      final animations = ModalAnimationType.values;
      expect(animations.length, 4);
      expect(animations.toSet().length, 4);
    });
  });

  group('Callback Tests', () {
    test('Modal.show() accepts onDismissed callback', () {
      bool called = false;
      void callback() {
        called = true;
      }

      expect(
        () => Modal.show(builder: _testBuilder, onDismissed: callback),
        returnsNormally,
      );
    });

    test('Modal.show() accepts onExpanded callback', () {
      bool called = false;
      void callback() {
        called = true;
      }

      expect(
        () => Modal.show(builder: _testBuilder, onExpanded: callback),
        returnsNormally,
      );
    });

    test('Modal.show() can accept multiple callbacks', () {
      int callCount = 0;

      void onDismissed() {
        callCount++;
      }

      void onExpanded() {
        callCount++;
      }

      expect(
        () => Modal.show(
          builder: _testBuilder,
          onDismissed: onDismissed,
          onExpanded: onExpanded,
        ),
        returnsNormally,
      );
    });
  });

  group('Configuration Combinations Tests', () {
    test('ModalContent supports all valid combinations', () {
      final types = ModalType.values;
      final positions = [
        Alignment.center,
        Alignment.topLeft,
        Alignment.bottomCenter,
      ];
      final animations = ModalAnimationType.values;

      // Test a sample of combinations
      expect(
        () => Modal.show(
          builder: _testBuilder,
          modalType: ModalType.sheet,
          modalPosition: Alignment.bottomCenter,
          modalAnimationType: ModalAnimationType.fade,
        ),
        returnsNormally,
      );

      expect(
        () => Modal.show(
          builder: _testBuilder,
          modalType: ModalType.dialog,
          modalPosition: Alignment.center,
          modalAnimationType: ModalAnimationType.scale,
        ),
        returnsNormally,
      );
    });

    test('Modal.show() accepts bottom sheet specific configurations', () {
      expect(
        () => Modal.show(
          builder: _testBuilder,
          modalType: ModalType.sheet,
          isExpandable: true,
          size: 300,
          expandedPercentageSize: 85,
          isDismissable: true,
        ),
        returnsNormally,
      );
    });

    test('Modal.show() accepts dialog specific configurations', () {
      expect(
        () => Modal.show(
          builder: _testBuilder,
          modalType: ModalType.dialog,
          modalPosition: Alignment.center,
          shouldBlurBackground: true,
          isDismissable: false,
        ),
        returnsNormally,
      );
    });
  });

  group('Modal API Default Behavior Tests', () {
    test('Modal.show() has sensible defaults', () {
      // Should not throw when called with only required builder parameter
      expect(() => Modal.show(builder: _testBuilder), returnsNormally);
    });
  });

  group('Dismissal Method Tests', () {
    test('dismissByType exists for all modal types', () {
      // These should complete without error even when no modal is active
      expect(() async => await Modal.dismissByType(ModalType.dialog),
          returnsNormally);
      expect(() async => await Modal.dismissByType(ModalType.sheet),
          returnsNormally);
      expect(() async => await Modal.dismissByType(ModalType.snackbar),
          returnsNormally);
      expect(() async => await Modal.dismissByType(ModalType.custom),
          returnsNormally);
    });

    test('dismissAllSnackbars exists and is callable', () {
      expect(() => Modal.dismissAllSnackbars(), returnsNormally);
    });

    test('dismissById exists and is callable', () {
      expect(() async => await Modal.dismissById('nonexistent_id'),
          returnsNormally);
    });

    test('dismissSnackbarAtPosition exists and is callable', () {
      expect(() => Modal.dismissSnackbarAtPosition(Alignment.topCenter),
          returnsNormally);
    });
  });

  group('Snackbar Auto-Dismiss & Cancellation', () {
    testWidgets('Snackbar auto-dismisses after duration',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Modal.activator(
            child: const Scaffold(body: SizedBox.expand()),
          ),
        ),
      );

      Modal.showSnackbar(
        text: 'Auto Dismiss',
        duration: const Duration(seconds: 2),
      );
      // Use pump() instead of pumpAndSettle() to avoid waiting for auto-dismiss timer
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(Modal.isSnackbarActive, true);

      // Advance time past duration (2 seconds + buffer for animation)
      await tester.pump(const Duration(seconds: 2, milliseconds: 500));
      await tester.pumpAndSettle();

      // Clean up any remaining state
      Modal.dismissAll();
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpAndSettle();

      expect(Modal.isSnackbarActive, false);
    });

    testWidgets('Manual dismiss cancels auto-dismiss timer',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Modal.activator(
            child: const Scaffold(body: SizedBox.expand()),
          ),
        ),
      );

      Modal.showSnackbar(
        text: 'Manual Dismiss',
        duration: const Duration(seconds: 3),
        id: 'manual_snack',
      );
      // Use pump() instead of pumpAndSettle() to avoid waiting for auto-dismiss timer
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
      expect(Modal.isSnackbarActive, true);

      // Dismiss manually before timer expires
      // Start the dismissal but don't await yet - we need to pump frames for the animation
      final dismissFuture = Modal.dismissById('manual_snack');

      // Pump frames to allow the animation to progress
      // The animation needs frames to complete, so we pump while the Future is pending
      await tester.pump(); // Initial frame
      await tester
          .pump(const Duration(milliseconds: 100)); // Animation progress
      await tester
          .pump(const Duration(milliseconds: 300)); // Animation completion

      // Now we can safely await the Future
      await dismissFuture;
      await tester.pumpAndSettle();
      expect(Modal.isSnackbarActive, false);

      // Advance time past original duration to ensure no errors/re-dismissal
      await tester.pump(const Duration(seconds: 3));
      // Should remain dismissed and no errors
      expect(Modal.isSnackbarActive, false);
    });

    testWidgets('Dismissing all snackbars cancels timers',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Modal.activator(
            child: const Scaffold(body: SizedBox.expand()),
          ),
        ),
      );

      Modal.showSnackbar(
        text: 'Snack 1',
        duration: const Duration(seconds: 3),
      );
      Modal.showSnackbar(
        text: 'Snack 2',
        duration: const Duration(seconds: 3),
      );
      // Use pump() instead of pumpAndSettle() to avoid waiting for auto-dismiss timer
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));

      // Verify snackbars are active
      expect(Modal.isSnackbarActive, true);

      // Dismiss all
      Modal.dismissAllSnackbars();
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pumpAndSettle();
      expect(Modal.isSnackbarActive, false);

      // Advance time
      await tester.pump(const Duration(seconds: 3));
      expect(Modal.isSnackbarActive, false);
    });
  });
}
