import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String text;
  final Color? color;
  final Color? textColor;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final GestureTapCallback onTap;
  final Widget? child;
  final BoxBorder? border;
  final bool loading;
  final bool disabled;
  final double? borderRadius;
  final Color disabledColor;

  const WButton({
    required this.onTap,
    this.width,
    this.borderRadius,
    this.height,
    this.text = '',
    this.color,
    this.textColor,
    this.textStyle,
    this.margin,
    this.padding,
    this.border,
    this.loading = false,
    this.disabled = false,
    this.disabledColor = Colors.grey,
    super.key,
    this.child,
  });

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
        opacity: disabled ? .3 : 1,
        duration: const Duration(milliseconds: 250),
        child: Padding(
          padding: margin ?? EdgeInsets.zero,
          child: WScale(
            onTap: () {
              if (!(loading || disabled)) {
                onTap();
              }
            },
            isDisabled: disabled,
            child: Container(
              width: width,
              height: height ?? 48.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: disabled ? disabledColor : color ?? AppColors.deepBlue,
                borderRadius: BorderRadius.circular(
                  borderRadius ?? 8.r,
                ),
                border: border,
              ),
              child: switch (loading) {
                (true) => Center(
                      child: CupertinoActivityIndicator(
                    color: Colors.white,
                  )),
                (false) => child ??
                    Text(
                      text,
                      style: textStyle ??
                          Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
              },
            ),
          ),
        ),
      );
}
