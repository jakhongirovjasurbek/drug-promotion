import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoxedLabelIn extends FormField<String> {
  /// Creates a [FormField] that contains a [TextField].
  ///
  /// When a [controller] is specified, [initialValue] must be null (the
  /// default). If [controller] is null, then a [TextEditingController]
  /// will be constructed automatically and its `text` will be initialized
  /// to [initialValue] or the empty string.
  ///
  /// For documentation about the various parameters, see the [TextField] class
  /// and [TextField.new], the constructor.
  BoxedLabelIn({
    super.key,
    this.controller,
    // EdgeInsets? padding = const EdgeInsets.all(5),
    String? initialValue,
    this.focusNode,
    this.decoration = const InputDecoration(),
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction? textInputAction,
    TextStyle? style,
    StrutStyle? strutStyle,
    TextDirection? textDirection,
    TextAlign textAlign = TextAlign.start,
    TextAlignVertical? textAlignVertical,
    bool autofocus = false,
    bool readOnly = false,
    bool? showCursor,
    String obscuringCharacter = '•',
    bool obscureText = false,
    bool autocorrect = true,
    SmartDashesType? smartDashesType,
    SmartQuotesType? smartQuotesType,
    bool enableSuggestions = true,
    MaxLengthEnforcement? maxLengthEnforcement,
    this.maxLines = 1,
    int? minLines,
    bool expands = false,
    this.maxLength,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    TapRegionCallback? onTapOutside,
    VoidCallback? onEditingComplete,
    ValueChanged<String>? onFieldSubmitted,
    super.onSaved,
    super.validator,
    List<TextInputFormatter>? inputFormatters,
    bool? enabled,
    double cursorWidth = 2.0,
    double? cursorHeight,
    Radius? cursorRadius,
    Color? cursorColor,
    Brightness? keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool? enableInteractiveSelection,
    TextSelectionControls? selectionControls,
    this.buildCounter,
    ScrollPhysics? scrollPhysics,
    Iterable<String>? autofillHints,
    AutovalidateMode? autovalidateMode,
    ScrollController? scrollController,
    super.restorationId,
    bool enableIMEPersonalizedLearning = true,
    MouseCursor? mouseCursor,
    EditableTextContextMenuBuilder? contextMenuBuilder =
        _defaultContextMenuBuilder,
  })  : assert(initialValue == null || controller == null,
            'Both `initialValue` and `controller` cannot be set simultaneously.'),
        assert(obscuringCharacter.length == 1,
            '`obscuringCharacter` must be a single character.'),
        assert(maxLines == null || maxLines > 0,
            '`maxLines` must be greater than zero if set.'),
        assert(minLines == null || minLines > 0,
            '`minLines` must be greater than zero if set.'),
        assert(
            (maxLines == null) || (minLines == null) || (maxLines >= minLines),
            '`minLines` cannot be greater than `maxLines`.'),
        assert(!expands || (maxLines == null && minLines == null),
            '`minLines` and `maxLines` must be null if `expands` is true.'),
        assert(!obscureText || maxLines == 1,
            'Obscured text fields cannot be multiline; set `maxLines` to 1 when `obscureText` is true.'),
        assert(
            maxLength == null ||
                maxLength == TextField.noMaxLength ||
                maxLength > 0,
            '`maxLength` must be positive or set to `TextField.noMaxLength` if specified.'),
        super(
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          enabled: enabled ?? decoration?.enabled ?? true,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          builder: (field) {
            final _BoxedLabelInState state = field as _BoxedLabelInState;
            final InputDecoration effectiveDecoration = (decoration ??
                    const InputDecoration())
                .applyDefaults(Theme.of(field.context).inputDecorationTheme);

            final InputDecoration innerDecoration = state
                ._getEffectiveDecoration
                .applyDefaults(Theme.of(field.context).inputDecorationTheme)
                .copyWithClean(
                  fillColor: Colors.transparent,
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                  isDense: false,

                  ///
                  border: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,

                  ///
                  errorStyle: const TextStyle(
                    height: 0,
                    fontSize: 0,
                  ),
                  errorStyleClean: true,
                  errorMaxLinesClean: true,
                  errorTextClean: true,
                  helperStyle: const TextStyle(
                    height: 0,
                    fontSize: 0,
                  ),
                  helperMaxLinesClean: true,
                  helperStyleClean: true,
                  helperTextClean: true,
                  focusColorClean: true,
                  //
                  iconClean: true,
                  iconColorClean: true,
                  //
                  constraintsClean: true,
                  //
                  counterClean: true,
                  counterTextClean: true,
                  counterStyleClean: true,
                  semanticCounterTextClean: true,
                );

            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            Widget child = TextField(
              restorationId: restorationId,
              controller: state._effectiveController,
              focusNode: state._effectiveFocusNode,
              decoration: innerDecoration,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: style,
              strutStyle: strutStyle,
              textAlign: textAlign,
              textAlignVertical: textAlignVertical,
              textDirection: textDirection,
              textCapitalization: textCapitalization,
              autofocus: autofocus,
              readOnly: readOnly,
              showCursor: showCursor,
              obscuringCharacter: obscuringCharacter,
              obscureText: obscureText,
              autocorrect: autocorrect,
              smartDashesType: smartDashesType ??
                  (obscureText
                      ? SmartDashesType.disabled
                      : SmartDashesType.enabled),
              smartQuotesType: smartQuotesType ??
                  (obscureText
                      ? SmartQuotesType.disabled
                      : SmartQuotesType.enabled),
              enableSuggestions: enableSuggestions,
              maxLengthEnforcement: maxLengthEnforcement,
              maxLines: maxLines,
              minLines: minLines,
              expands: expands,
              maxLength: maxLength,
              onChanged: onChangedHandler,
              onTap: onTap,
              onTapOutside: onTapOutside,
              onEditingComplete: onEditingComplete,
              onSubmitted: onFieldSubmitted,
              inputFormatters: inputFormatters,
              enabled: enabled ?? decoration?.enabled ?? true,
              cursorWidth: cursorWidth,
              cursorHeight: cursorHeight,
              cursorRadius: cursorRadius,
              cursorColor: cursorColor,
              scrollPadding: scrollPadding,
              scrollPhysics: scrollPhysics,
              keyboardAppearance: keyboardAppearance,
              enableInteractiveSelection:
                  enableInteractiveSelection ?? (!obscureText || !readOnly),
              selectionControls: selectionControls,
              buildCounter: buildCounter,
              autofillHints: autofillHints,
              scrollController: scrollController,
              enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
              mouseCursor: mouseCursor,
              contextMenuBuilder: contextMenuBuilder,
            );
            child = AnimatedBuilder(
              animation: Listenable.merge(<Listenable>[
                state._effectiveFocusNode,
                state._effectiveController
              ]),
              builder: (context, child) {
                return InputDecorator(
                  decoration: state._getEffectiveDecoration.copyWithClean(
                    errorText: field.errorText,

                    hintMaxLinesClean: true,
                    hintTextClean: true,
                    hintStyleClean: true,
                    hintTextDirectionClean: true,
//
                    labelClean: true,
                    labelStyleClean: true,
                    labelTextClean: true,
                    floatingLabelStyleClean: true,
                    floatingLabelAlignmentClean: true,
                    floatingLabelBehaviorClean: true,
                    alignLabelWithHintClean: true,
                    //
                    prefixClean: true,
                    prefixIconClean: true,
                    prefixTextClean: true,
                    prefixStyleClean: true,
                    prefixIconColorClean: true,
                    prefixIconConstraintsClean: true,
                    //
                    suffixClean: true,
                    suffixIconClean: true,
                    suffixTextClean: true,
                    suffixStyleClean: true,
                    suffixIconColorClean: true,
                    suffixIconConstraintsClean: true,
                  ),
                  textAlign: textAlign,
                  textAlignVertical: textAlignVertical,
                  isFocused: state._effectiveFocusNode.hasFocus,
                  isEmpty: state._effectiveController.value.text.isEmpty,
                  child: child,
                );
              },
              child: child,
            );
            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: child,
            );
          },
        );

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final int? maxLength;
  final InputCounterWidgetBuilder? buildCounter;
  final int? maxLines;

  static Widget _defaultContextMenuBuilder(
      BuildContext context, EditableTextState editableTextState) {
    return AdaptiveTextSelectionToolbar.editableText(
      editableTextState: editableTextState,
    );
  }

  @override
  FormFieldState<String> createState() => _BoxedLabelInState();
}

class _BoxedLabelInState extends FormFieldState<String> {
  RestorableTextEditingController? _controller;

  // RestorableTextEditingController? _controller;
  FocusNode? _focusNode;

  TextEditingController get _effectiveController =>
      _textFormField.controller ?? _controller!.value;

  FocusNode get _effectiveFocusNode =>
      _textFormField.focusNode ?? (_focusNode ??= FocusNode());

  bool get _isEnabled => _textFormField.enabled;

  int get _currentLength => _effectiveController.value.text.characters.length;

  bool get _hasIntrinsicError =>
      _textFormField.maxLength != null &&
      _textFormField.maxLength! > 0 &&
      _effectiveController.value.text.characters.length >
          _textFormField.maxLength!;

  bool get _hasError =>
      _textFormField.decoration?.errorText != null || _hasIntrinsicError;

  InputDecoration get _getEffectiveDecoration {
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    final ThemeData themeData = Theme.of(context);
    final InputDecoration effectiveDecoration =
        (_textFormField.decoration ?? const InputDecoration())
            .applyDefaults(themeData.inputDecorationTheme)
            .copyWith(
              enabled: _isEnabled,
              hintMaxLines: _textFormField.decoration?.hintMaxLines ??
                  _textFormField.maxLines,
            );

    // No need to build anything if counter or counterText were given directly.
    if (effectiveDecoration.counter != null ||
        effectiveDecoration.counterText != null) {
      return effectiveDecoration;
    }

    // If buildCounter was provided, use it to generate a counter widget.
    Widget? counter;
    final int currentLength = _currentLength;
    if (effectiveDecoration.counter == null &&
        effectiveDecoration.counterText == null &&
        _textFormField.buildCounter != null) {
      final bool isFocused = _effectiveFocusNode.hasFocus;
      final Widget? builtCounter = _textFormField.buildCounter!(
        context,
        currentLength: currentLength,
        maxLength: _textFormField.maxLength,
        isFocused: isFocused,
      );
      // If buildCounter returns null, don't add a counter widget to the field.
      if (builtCounter != null) {
        counter = Semantics(
          container: true,
          liveRegion: isFocused,
          child: builtCounter,
        );
      }
      return effectiveDecoration.copyWith(counter: counter);
    }

    if (_textFormField.maxLength == null) {
      return effectiveDecoration;
    } // No counter widget

    String counterText = '$currentLength';
    String semanticCounterText = '';

    // Handle a real maxLength (positive number)
    if (_textFormField.maxLength! > 0) {
      // Show the maxLength in the counter
      counterText += '/${_textFormField.maxLength}';
      final int remaining = (_textFormField.maxLength! - currentLength)
          .clamp(0, _textFormField.maxLength!); // ignore_clamp_double_lint
      semanticCounterText =
          localizations.remainingTextFieldCharacterCount(remaining);
    }

    if (_hasIntrinsicError) {
      return effectiveDecoration.copyWith(
        errorText: effectiveDecoration.errorText ?? '',
        counterStyle: effectiveDecoration.errorStyle ??
            (themeData.useMaterial3
                ? _m3CounterErrorStyle(context)
                : _m2CounterErrorStyle(context)),
        counterText: counterText,
        semanticCounterText: semanticCounterText,
      );
    }

    return effectiveDecoration.copyWith(
      counterText: counterText,
      semanticCounterText: semanticCounterText,
    );
  }

  BoxedLabelIn get _textFormField => super.widget as BoxedLabelIn;

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    super.restoreState(oldBucket, initialRestore);
    if (_controller != null) {
      _registerController();
    }
    // Make sure to update the internal [FormFieldState] value to sync up with
    // text editing controller value.
    setValue(_effectiveController.text);
  }

  void _registerController() {
    assert(_controller != null);
    registerForRestoration(_controller!, 'controller');
  }

  void _createLocalController([TextEditingValue? value]) {
    assert(_controller == null);
    _controller = value == null
        ? RestorableTextEditingController()
        : RestorableTextEditingController.fromValue(value);
    if (!restorePending) {
      _registerController();
    }
  }

  @override
  void initState() {
    super.initState();
    if (_textFormField.controller == null) {
      _createLocalController(widget.initialValue != null
          ? TextEditingValue(text: widget.initialValue!)
          : null);
    } else {
      _textFormField.controller!.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(BoxedLabelIn oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_textFormField.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      _textFormField.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && _textFormField.controller == null) {
        _createLocalController(oldWidget.controller!.value);
      }

      if (_textFormField.controller != null) {
        setValue(_textFormField.controller!.text);
        if (oldWidget.controller == null) {
          unregisterFromRestoration(_controller!);
          _controller!.dispose();
          _controller = null;
        }
      }
    }
  }

  @override
  void dispose() {
    _textFormField.controller?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    // setState will be called in the superclass, so even though state is being
    // manipulated, no setState call is needed here.
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }
}
// TextStyle _m3InputStyle(BuildContext context) => Theme.of(context).textTheme.bodyLarge!;

TextStyle _m3CounterErrorStyle(BuildContext context) => Theme.of(context)
    .textTheme
    .bodySmall!
    .copyWith(color: Theme.of(context).colorScheme.error);

TextStyle _m2CounterErrorStyle(BuildContext context) => Theme.of(context)
    .textTheme
    .bodySmall!
    .copyWith(color: Theme.of(context).colorScheme.error);

extension on InputDecoration {
  InputDecoration copyWithClean({
    Widget? icon,
    Color? iconColor,
    Widget? label,
    String? labelText,
    TextStyle? labelStyle,
    TextStyle? floatingLabelStyle,
    String? helperText,
    TextStyle? helperStyle,
    int? helperMaxLines,
    String? hintText,
    TextStyle? hintStyle,
    TextDirection? hintTextDirection,
    int? hintMaxLines,
    String? errorText,
    TextStyle? errorStyle,
    int? errorMaxLines,
    FloatingLabelBehavior? floatingLabelBehavior,
    FloatingLabelAlignment? floatingLabelAlignment,
    bool? isCollapsed,
    bool? isDense,
    EdgeInsetsGeometry? contentPadding,
    Widget? prefixIcon,
    Widget? prefix,
    String? prefixText,
    BoxConstraints? prefixIconConstraints,
    TextStyle? prefixStyle,
    Color? prefixIconColor,
    Widget? suffixIcon,
    Widget? suffix,
    String? suffixText,
    TextStyle? suffixStyle,
    Color? suffixIconColor,
    BoxConstraints? suffixIconConstraints,
    Widget? counter,
    String? counterText,
    TextStyle? counterStyle,
    bool? filled,
    Color? fillColor,
    Color? focusColor,
    Color? hoverColor,
    InputBorder? errorBorder,
    InputBorder? focusedBorder,
    InputBorder? focusedErrorBorder,
    InputBorder? disabledBorder,
    InputBorder? enabledBorder,
    InputBorder? border,
    bool? enabled,
    String? semanticCounterText,
    bool? alignLabelWithHint,
    BoxConstraints? constraints,
    bool iconClean = false,
    bool iconColorClean = false,
    bool labelClean = false,
    bool labelTextClean = false,
    bool labelStyleClean = false,
    bool floatingLabelStyleClean = false,
    bool helperTextClean = false,
    bool helperStyleClean = false,
    bool helperMaxLinesClean = false,
    bool hintTextClean = false,
    bool hintStyleClean = false,
    bool hintTextDirectionClean = false,
    bool hintMaxLinesClean = false,
    bool errorTextClean = false,
    bool errorStyleClean = false,
    bool errorMaxLinesClean = false,
    bool floatingLabelBehaviorClean = false,
    bool floatingLabelAlignmentClean = false,
    bool isDenseClean = false,
    bool contentPaddingClean = false,
    bool prefixIconClean = false,
    bool prefixClean = false,
    bool prefixTextClean = false,
    bool prefixIconConstraintsClean = false,
    bool prefixStyleClean = false,
    bool prefixIconColorClean = false,
    bool suffixIconClean = false,
    bool suffixClean = false,
    bool suffixTextClean = false,
    bool suffixStyleClean = false,
    bool suffixIconColorClean = false,
    bool suffixIconConstraintsClean = false,
    bool counterClean = false,
    bool counterTextClean = false,
    bool counterStyleClean = false,
    bool filledClean = false,
    bool fillColorClean = false,
    bool focusColorClean = false,
    bool hoverColorClean = false,
    bool errorBorderClean = false,
    bool focusedBorderClean = false,
    bool focusedErrorBorderClean = false,
    bool disabledBorderClean = false,
    bool enabledBorderClean = false,
    bool borderClean = false,
    bool semanticCounterTextClean = false,
    bool alignLabelWithHintClean = false,
    bool constraintsClean = false,
  }) {
    return InputDecoration(
      icon: iconClean ? null : icon ?? this.icon,
      iconColor: iconColorClean ? null : iconColor ?? this.iconColor,
      label: labelClean ? null : label ?? this.label,
      labelText: labelTextClean ? null : labelText ?? this.labelText,
      labelStyle: labelStyleClean ? null : labelStyle ?? this.labelStyle,
      floatingLabelStyle: floatingLabelStyleClean
          ? null
          : floatingLabelStyle ?? this.floatingLabelStyle,
      helperText: helperTextClean ? null : helperText ?? this.helperText,
      helperStyle: helperStyleClean ? null : helperStyle ?? this.helperStyle,
      helperMaxLines:
          helperMaxLinesClean ? null : helperMaxLines ?? this.helperMaxLines,
      hintText: hintTextClean ? null : hintText ?? this.hintText,
      hintStyle: hintStyleClean ? null : hintStyle ?? this.hintStyle,
      hintTextDirection: hintTextDirectionClean
          ? null
          : hintTextDirection ?? this.hintTextDirection,
      hintMaxLines:
          hintMaxLinesClean ? null : hintMaxLines ?? this.hintMaxLines,
      errorText: errorTextClean ? null : errorText ?? this.errorText,
      errorStyle: errorStyleClean ? null : errorStyle ?? this.errorStyle,
      errorMaxLines:
          errorMaxLinesClean ? null : errorMaxLines ?? this.errorMaxLines,
      floatingLabelBehavior: floatingLabelBehaviorClean
          ? null
          : floatingLabelBehavior ?? this.floatingLabelBehavior,
      floatingLabelAlignment: floatingLabelAlignmentClean
          ? null
          : floatingLabelAlignment ?? this.floatingLabelAlignment,
      isCollapsed: isCollapsed ?? this.isCollapsed,
      isDense: isDenseClean ? null : isDense ?? this.isDense,
      contentPadding:
          contentPaddingClean ? null : contentPadding ?? this.contentPadding,
      prefixIcon: prefixIconClean ? null : prefixIcon ?? this.prefixIcon,
      prefix: prefixClean ? null : prefix ?? this.prefix,
      prefixText: prefixTextClean ? null : prefixText ?? this.prefixText,
      prefixIconConstraints: prefixIconConstraintsClean
          ? null
          : prefixIconConstraints ?? this.prefixIconConstraints,
      prefixStyle: prefixStyleClean ? null : prefixStyle ?? this.prefixStyle,
      prefixIconColor:
          prefixIconColorClean ? null : prefixIconColor ?? this.prefixIconColor,
      suffixIcon: suffixIconClean ? null : suffixIcon ?? this.suffixIcon,
      suffix: suffixClean ? null : suffix ?? this.suffix,
      suffixText: suffixTextClean ? null : suffixText ?? this.suffixText,
      suffixStyle: suffixStyleClean ? null : suffixStyle ?? this.suffixStyle,
      suffixIconColor:
          suffixIconColorClean ? null : suffixIconColor ?? this.suffixIconColor,
      suffixIconConstraints: suffixIconConstraintsClean
          ? null
          : suffixIconConstraints ?? this.suffixIconConstraints,
      counter: counterClean ? null : counter ?? this.counter,
      counterText: counterTextClean ? null : counterText ?? this.counterText,
      counterStyle:
          counterStyleClean ? null : counterStyle ?? this.counterStyle,
      filled: filledClean ? null : filled ?? this.filled,
      fillColor: fillColorClean ? null : fillColor ?? this.fillColor,
      focusColor: focusColorClean ? null : focusColor ?? this.focusColor,
      hoverColor: hoverColorClean ? null : hoverColor ?? this.hoverColor,
      errorBorder: errorBorderClean ? null : errorBorder ?? this.errorBorder,
      focusedBorder:
          focusedBorderClean ? null : focusedBorder ?? this.focusedBorder,
      focusedErrorBorder: focusedErrorBorderClean
          ? null
          : focusedErrorBorder ?? this.focusedErrorBorder,
      disabledBorder:
          disabledBorderClean ? null : disabledBorder ?? this.disabledBorder,
      enabledBorder:
          enabledBorderClean ? null : enabledBorder ?? this.enabledBorder,
      border: borderClean ? null : border ?? this.border,
      enabled: enabled ?? this.enabled,
      semanticCounterText: semanticCounterTextClean
          ? null
          : semanticCounterText ?? this.semanticCounterText,
      alignLabelWithHint: alignLabelWithHintClean
          ? null
          : alignLabelWithHint ?? this.alignLabelWithHint,
      constraints: constraintsClean ? null : constraints ?? this.constraints,
    );
  }
}
