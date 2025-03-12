import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/widgets/text_field/boxed_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'enums.dart';
part 'mixins.dart';

/// A customizable text input field with additional options like prefix icon,
/// clear text button, and custom label styling.
class WTextFormField extends StatefulWidget {
  /// Padding around the text field widget.
  final EdgeInsets margin;

  /// Hint text to be displayed when the field is empty.
  final String? hintText;

  /// Determines if the text field is disabled (read-only).
  final bool isDisabled;

  /// Optional label to display above the input field.
  final String? label;

  /// Displays an asterisk (*) if the field is required.
  final bool isRequired;

  /// Controller to handle the input text.
  final TextEditingController? controller;

  /// Function to validate the input.
  final String? Function(String?)? validator;

  /// Displays a success style if set to true.
  final bool isSuccess;

  /// Widget to be used as a prefix, typically an icon.
  final Widget? prefix;

  /// Adds a button to clear the text if set to true.
  final bool hasClearText;

  /// Widget to be used as a suffix, such as a custom icon or button.
  final Widget? suffixIcon;

  /// Widget to be used as a suffix, such as a custom icon or button.
  final Widget? suffix;

  /// FocusNode to manage the input focus.
  final FocusNode? focusNode;

  /// Alignment of the input text within the field.
  final TextAlign textAlign;

  /// Callback function triggered when the input changes.
  final ValueChanged<String>? onChanged;

  final VoidCallback? onCompleted;

  final String? initialValue;

  final AutovalidateMode? autoValidateMode;

  final TextCapitalization? textCapitalization;

  final Color? fillColor;

  final EdgeInsets? contentPadding;

  final TextStyle? style;

  final TextStyle? floatingLabelStyle;

  final TextInputType? keyboardType;

  final List<TextInputFormatter>? inputFormatters;

  final TextInputAction? textInputAction;

  final String? prefixText;

  final BoxConstraints? suffixIconConstraints;

  final Color? disabledBorderColor;

  final bool autoFocus;

  final String? error;

  final TextStyle? hintStyle;

  /// Constructor for the TextFormFieldX widget.
  const WTextFormField({
    super.key,
    this.onChanged,
    this.onCompleted,
    this.isDisabled = false,
    this.isRequired = false,
    this.isSuccess = false,
    this.hasClearText = false,
    this.autoFocus = false,
    this.margin = EdgeInsets.zero,
    this.textAlign = TextAlign.start,
    this.hintText,
    this.controller,
    this.validator,
    this.prefix,
    this.label,
    this.suffixIcon,
    this.focusNode,
    this.initialValue,
    this.autoValidateMode,
    this.textCapitalization,
    this.fillColor,
    this.contentPadding,
    this.style,
    this.floatingLabelStyle,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction,
    this.prefixText,
    this.suffix,
    this.suffixIconConstraints,
    this.disabledBorderColor,
    this.error,
    this.hintStyle,
  }) : assert(
          !hasClearText || controller != null,
          'If hasClearText is true, controller must not be null',
        );

  @override
  State<WTextFormField> createState() => _WTextFormFieldState();
}

class _WTextFormFieldState extends State<WTextFormField>
    with _TextFormFieldXWrapper {
  TextEditingController? _controller;
  late FocusNode focusNode;
  bool hasFocus = false;
  bool hasValue = false;

  void _handleInputFilling() {
    if (!mounted) return;

    if (_controller?.text case String value
        when value.isNotEmpty && !hasValue) {
      setState(() => hasValue = true);
    } else if (_controller?.text case String value
        when value.isEmpty && hasValue) {
      setState(() => hasValue = false);
    }
  }

  void _handleFocus() {
    if (!mounted) return;

    if (focusNode.hasFocus) {
      setState(() => hasFocus = true);
    } else {
      setState(() => hasFocus = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialValue);
    focusNode = widget.focusNode ?? FocusNode();

    hasValue = _controller?.text != '';

    focusNode.addListener(_handleFocus);
    _controller?.addListener(_handleInputFilling);
  }

  @override
  void dispose() {
    _controller?.removeListener(_handleInputFilling);

    if (widget.controller == null) _controller?.dispose();

    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final yMatrixVal = hasFocus || hasValue ? 6.0 : 0.0;

    return BoxedLabelIn(
      onEditingComplete: widget.onCompleted,
      textInputAction: widget.textInputAction,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      autofocus: widget.autoFocus,
      textCapitalization: widget.textCapitalization ?? TextCapitalization.none,
      autovalidateMode: widget.autoValidateMode,
      textAlignVertical: TextAlignVertical.center,
      focusNode: focusNode,
      textAlign: widget.textAlign,
      onChanged: widget.onChanged,
      controller: _controller,
      readOnly: widget.isDisabled,
      validator: widget.validator,
      cursorColor: AppColors.deepBlue,
      cursorHeight: 16.h,
      cursorWidth: 1.5.w,
      cursorRadius: Radius.zero,
      decoration: InputDecoration(
        errorText: widget.error,
        prefixText: widget.prefixText,
        errorMaxLines: 1,
        hintText: widget.hintText,
        enabled: !widget.isDisabled,
        suffixIcon: widget.suffixIcon,
        suffixIconConstraints: widget.suffixIconConstraints,
        hintStyle: widget.hintStyle,
        contentPadding: widget.contentPadding ??
            EdgeInsets.fromLTRB(
              16.w,
              6.h,
              16.w,
              6.h,
            ),
        floatingLabelStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.deepBlue,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
        label: Transform(
          transform: Matrix4.translationValues(0, yMatrixVal, 0),
          child: Text(
            widget.label ?? '',
            style: widget.floatingLabelStyle,
          ),
        ),
        suffix: widget.suffix,
        fillColor: Colors.white,
        border: getBorder(
          _TextFormFieldStatus.pure,
          disabledBorderColor: widget.disabledBorderColor,
        ),
        enabledBorder: getBorder(
          _TextFormFieldStatus.pure,
          disabledBorderColor: widget.disabledBorderColor,
        ),
        disabledBorder: getBorder(
          _TextFormFieldStatus.pure,
          disabledBorderColor: widget.disabledBorderColor,
        ),
        errorBorder: getBorder(
          _TextFormFieldStatus.error,
          disabledBorderColor: widget.disabledBorderColor,
        ),
        focusedBorder: getBorder(
          _TextFormFieldStatus.focused,
          disabledBorderColor: widget.disabledBorderColor,
        ),
        prefixIcon: widget.prefix,
      ),
    );
  }
}
