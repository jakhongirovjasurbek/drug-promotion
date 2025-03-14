import 'package:drugpromotion/assets/assets.dart';
import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;
  final bool hasDivider;
  final Color? textColor;

  const ProfileItem({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.hasDivider = true,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: WScale(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(icon, width: 20.w),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  color: textColor ?? AppColors.blackish,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ),
                        SvgPicture.asset(AppAssets.arrowRightChevron),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    if (hasDivider)
                      Divider(height: 1.h, color: AppColors.whitish),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
