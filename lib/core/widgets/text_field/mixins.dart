part of './text_field.dart';

/// A mixin providing utility methods and properties for the `TextFormFieldX` widget.
///
/// This mixin includes methods for handling text field borders based on different states,
/// and a utility method to generate a prefix widget.
mixin _TextFormFieldXWrapper {
  /// A function to create a consistent border style for the text field,
  /// using the specified color.
  Function border = (Color color) => OutlineInputBorder(
        borderSide: BorderSide(width: 2.w, color: color),
        borderRadius: BorderRadius.circular(8.r),
      );

  /// Returns the appropriate border for the text field based on its current status.
  ///
  /// The status could be one of the following:
  /// - `pure`: Default state, uses the secondary border color.
  /// - `focused`: When the field is active, uses the primary border color.
  /// - `success`: On successful input, uses the success border color.
  /// - `error`: When there is a validation error, uses the error border color.
  /// - `disabled`: When the field is disabled, uses the secondary border color.
  ///
  /// If the `isDisabled` property is set to `true`, the field will always use the
  /// secondary border color regardless of its status.
  InputBorder getBorder(
    _TextFormFieldStatus status, {
    Color? disabledBorderColor,
  }) {
    return switch (status) {
      _TextFormFieldStatus.pure => border(AppColors.whitish),
      _TextFormFieldStatus.focused => border(AppColors.deepBlue),
      _TextFormFieldStatus.error => border(Colors.red),
      _TextFormFieldStatus.disabled => border(AppColors.whitish),
    };
  }
}
