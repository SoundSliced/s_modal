# Animation Controller Conflict Fix

## Problem Identified

There was a critical issue where snackbars could share the same animation state during dismissal, causing unexpected behavior when:
1. A snackbar is being dismissed (animation still playing)
2. Another snackbar is shown immediately
3. The new snackbar would also get dismissed because it received `isDismissing: true`

This happened because:
1. **Global dismissing flag**: `_snackbarDismissingNotifier` was a single boolean shared by ALL snackbars
2. When one snackbar was dismissed, `_snackbarDismissingNotifier.state = true` was set
3. **ALL visible snackbars** received `isDismissing: Modal.isSnackbarDismissing` (which was `true`)
4. New snackbars shown during this window also got `isDismissing: true`

## Solution Implemented

### 1. **Per-Snackbar Dismissing State** (s_modal.dart)
Changed from a global boolean flag to a **Set of dismissing snackbar IDs**:

```dart
// OLD: Single boolean for ALL snackbars
final _snackbarDismissingNotifier = RM.inject<bool>(() => false);

// NEW: Set of snackbar IDs currently being dismissed
final _snackbarDismissingIdsNotifier = RM.inject<Set<String>>(() => {});

/// Check if a specific snackbar is being dismissed
bool _isSnackbarDismissing(String? snackbarId) {
  if (snackbarId == null) return false;
  return _snackbarDismissingIdsNotifier.state.contains(snackbarId);
}

/// Mark a snackbar as dismissing
void _setSnackbarDismissing(String snackbarId, bool isDismissing) {
  final currentSet = Set<String>.from(_snackbarDismissingIdsNotifier.state);
  if (isDismissing) {
    currentSet.add(snackbarId);
  } else {
    currentSet.remove(snackbarId);
  }
  _snackbarDismissingIdsNotifier.state = currentSet;
  // Also update legacy boolean for backward compatibility
  _snackbarDismissingNotifier.state = currentSet.isNotEmpty;
}

/// Clear all snackbar dismissing states
void _clearAllSnackbarDismissing() {
  _snackbarDismissingIdsNotifier.state = {};
  _snackbarDismissingNotifier.state = false;
}
```

### 2. **Per-Snackbar isDismissing in UI** (s_modal.dart)
Updated all `SnackbarModal` widget creations to use per-snackbar dismissing checks:

```dart
// OLD: All snackbars share the same dismissing state
SnackbarModal(
  isDismissing: Modal.isSnackbarDismissing,  // ❌ Global flag
  ...
)

// NEW: Each snackbar checks its own dismissing state
SnackbarModal(
  isDismissing: _isSnackbarDismissing(snackbarContent.uniqueId),  // ✅ Per-snackbar
  ...
)
```

### 3. **Unique Animation Keys** (dialog/s_modal_dialog.dart, sheet/s_modal_sheet.dart)
Added unique ID parameters to ensure each modal has independent animation controllers:

```dart
// Dialog
class DialogModal extends StatefulWidget {
  final String? dialogId;  // ← NEW
  ...
}

// Build method uses dialogId for unique animation key
final animationKey = ValueKey("dialog_anim_${animationKeyId}_${widget.isDismissing}");
```

```dart
// Sheet
class _Sheet extends StatefulWidget {
  final String? sheetId;  // ← NEW
  ...
}

// Build method uses sheetId for unique animation key
final animationKey = ValueKey("sheet_anim_${animationKeyId}_show/dismissing");
```

## Key Benefits

- ✅ Each snackbar has its own **independent dismissing state**
- ✅ Dismissing one snackbar no longer affects others being shown
- ✅ Supports rapid modal switching without visual glitches
- ✅ Works across all modal types (dialogs, sheets, snackbars)
- ✅ All 52 existing tests still pass
- ✅ Backward compatible - legacy `Modal.isSnackbarDismissing` still works

## Files Modified

1. `lib/src/s_modal.dart`
   - Added `_snackbarDismissingIdsNotifier` (Set of IDs)
   - Added `_isSnackbarDismissing(id)` helper function
   - Added `_setSnackbarDismissing(id, bool)` helper function
   - Added `_clearAllSnackbarDismissing()` helper function
   - Updated all `SnackbarModal` creations to use per-snackbar dismissing
   - Updated all dismissal logic to use per-snackbar state
   - Added `_snackbarDismissingIdsNotifier` to OnBuilder listeners
   - Pass `sheetId` and `dialogId` when creating widgets

2. `lib/src/dialog/s_modal_dialog.dart`
   - Added `dialogId` parameter
   - Updated animation keys to include dialogId

3. `lib/src/sheet/s_modal_sheet.dart`
   - Added `sheetId` parameter
   - Updated animation keys to include sheetId

4. `lib/src/snackbar/s_modal_snackbar.dart`
   - Verified proper unique ID handling (already had snackbarId)
