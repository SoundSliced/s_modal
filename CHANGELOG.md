## 1.0.1

* Version 1.0.1

# Changelog

All notable changes to the s_modal package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-01-01

### 🎉 Initial Release

The first stable release of `s_modal` - a comprehensive Flutter package for modal overlays.

#### ✨ Features Added

**Core Modal Types:**
- ✅ **Sheets**: Bottom, top, left, and right edge sheets with drag-to-expand functionality
- ✅ **Dialogs**: Centered modal dialogs with optional draggable and offset positioning
- ✅ **Snackbars**: Smart notifications with multiple display modes and auto-dismiss

**Sheet Features:**
- Expandable sheets with configurable max size (percentage of screen)
- Interactive drag handle for user-friendly interaction
- Support for all four edges (bottom, top, left, right)
- Auto-sizing based on content or fixed dimensions
- Customizable colors, borders, and shadows
- Smooth entrance and exit animations

**Dialog Features:**
- Centered positioning with optional pixel-based offset
- Optional draggable functionality to reposition on screen
- Fade and scale animations
- Customizable background blur and barrier color
- Support for any alignment position

**Snackbar Features:**
- 9 standard alignment positions + custom offset positioning
- 4 display modes: staggered, notification bubble, queued, replace
- Auto-dismiss with optional duration
- Visual duration indicator with left-to-right or right-to-left animation
- Swipe-to-dismiss (horizontal and vertical)
- Customizable icons, colors, and action buttons
- Smart stacking with configurable max stack size

**Advanced Features:**
- **Independent Lifecycles**: Each modal type (sheet, dialog, snackbar) has its own controller for conflict-free operation
- **Live Updates**: `Modal.updateParams()` for real-time property changes without recreation
- **ID-Based Management**: Assign IDs to modals for precise control and tracking
- **Hot Reload Support**: `ModalBuilder` widget preserves state during development
- **Type-Safe API**: Comprehensive enums for all configurations
- **Background Effects**: Customizable blur amount (0-20) and barrier colors
- **Callbacks**: `onDismissed`, `onExpanded`, and `onTap` hooks
- **Smart Dismissal**: Tap outside, swipe gestures, or programmatic control

**Developer Experience:**
- Comprehensive example app with interactive configurators
- Extensive test coverage (unit and integration tests)
- Detailed inline documentation
- Hot reload support for rapid development
- Type-safe APIs with helpful IDE autocomplete

**State Management:**
- Built on states_rebuilder_extended for reactive state
- Separate controllers for each modal type prevent conflicts
- Global registry tracks all active modals
- Per-snackbar animation controllers for independent lifecycles

**API Methods:**
- `Modal.show()` - Display any modal type with full customization
- `Modal.showSnackbar()` - Convenient pre-styled snackbar
- `Modal.dismiss()` / `dismissDialog()` / `dismissBottomSheet()` - Type-specific dismissal
- `Modal.dismissById()` - Dismiss by unique identifier
- `Modal.dismissAll()` - Clear all modals
- `Modal.dismissByType()` - Dismiss all modals of a specific type
- `Modal.dismissAllSnackbars()` - Clear all snackbars
- `Modal.updateParams()` - Live property updates
- `Modal.isModalActiveById()` - Check if specific modal is showing
- `ModalBuilder` / `ModalBuilder.dialog` / `ModalBuilder.snackbar` - Hot-reload-friendly widgets

**State Checks:**
- `Modal.isActive` - Check if any modal is showing
- `Modal.isDialogActive` / `isSheetActive` / `isSnackbarActive` - Type-specific checks
- `Modal.isDialogDismissing` / `isSheetDismissing` / `isSnackbarDismissing` - Animation state
- `Modal.activeModalId` - Get current modal's ID
- `Modal.allActiveModalIds` - List all active modal IDs
- `Modal.getActiveIdsByType()` - Filter by modal type

#### 🎨 Customization Options

**Sheet Customization:**
- Size (height for bottom/top, width for left/right)
- Expandable with max percentage size
- Background color
- Borders and border radius
- Content padding
- Drag handle visibility and styling

**Dialog Customization:**
- Position (any Alignment + custom Offset)
- Size constraints
- Draggable behavior
- Background blur and barrier color
- Border radius and shadows
- Animation types (fade, scale, slide, rotate)

**Snackbar Customization:**
- Position (9 alignments + custom offset)
- Width (percentage or fixed pixels)
- Display mode (staggered, bubble, queued, replace)
- Auto-dismiss duration
- Duration indicator (color, direction)
- Swipe-to-dismiss (horizontal/vertical)
- Icons (prefix and suffix)
- Colors (background, text, icons)
- Tap callback

**Global Options:**
- Background blur (enabled/disabled, intensity 0-20)
- Barrier color (any color with opacity)
- Dismissable on tap outside (true/false)
- Block background interaction (true/false)

#### 📦 Dependencies

- Flutter SDK >=3.0.0
- dart_helper_utils ^5.4.1
- states_rebuilder_extended ^1.0.3
- assorted_layout_widgets ^11.0.0
- sizer ^3.1.3
- flutter_animate ^4.5.2
- soundsliced_dart_extensions ^1.0.1
- s_bounceable ^2.0.0
- soundsliced_tween_animation_builder ^1.2.0
- s_ink_button ^1.1.0

#### 🐛 Known Issues

None at this time. Please report any issues on [GitHub](https://github.com/SoundSliced/s_modal/issues).

#### 📝 Notes

- This is the first stable release ready for production use
- All core features are fully tested and documented
- Comprehensive example app included
- MIT License

---

## Future Plans (Roadmap)

Potential features for future releases:

- [ ] Custom modal types beyond sheet/dialog/snackbar
- [ ] Additional animation presets
- [ ] Theme system for consistent styling across app
- [ ] Accessibility improvements (screen reader support, focus management)
- [ ] Performance optimizations for large modal counts
- [ ] More snackbar templates (success, error, warning, info)
- [ ] Gesture customization options
- [ ] Modal transition animations between types
- [ ] Nested modal support
- [ ] Modal history/stack management

---

For more information, see the [README](README.md) or visit the [GitHub repository](https://github.com/SoundSliced/s_modal).
