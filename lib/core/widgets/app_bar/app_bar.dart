import 'package:drugpromotion/assets/assets.dart';
import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WAppBar extends PreferredSize {
  final bool hasBackButton;
  final List<Widget>? actions;

  const WAppBar({
    super.key,
    required super.child,
    required super.preferredSize,
    this.hasBackButton = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 12.w,
          right: 12.w,
        ),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              color: Colors.black.withAlpha(70),
              blurRadius: 2,
            )
          ],
        ),
        child: Row(
          children: [
            if (hasBackButton)
              SizedBox(
                width: 84.w,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: Navigator.of(context).pop,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(AppAssets.arrowLeftChiron),
                      SizedBox(width: 12.w),
                      Text(
                        AppLocalization.current.back,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.deepBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                      )
                    ],
                  ),
                ),
              ),
            Expanded(child: Center(child: child)),
            if (actions != null) ...actions! else SizedBox(width: 84.w)
          ],
        ),
      ),
    );
  }
}
