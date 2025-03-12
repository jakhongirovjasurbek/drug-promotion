part of './text_field.dart';

/// An enumeration that represents the different states of a `TextFormFieldX` widget.
///
/// The states are used to determine the appropriate border and styling for the text field:
///
/// - `pure`: The default state when no interaction has occurred.
/// - `focused`: The state when the text field is currently active and selected.
/// - `success`: The state when input has been validated successfully.
/// - `error`: The state when there is an error in the input.
/// - `disabled`: The state when the text field is disabled and cannot be interacted with.
enum _TextFormFieldStatus {
  pure,
  focused,
  error,
  disabled,
}
