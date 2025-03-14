import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:drugpromotion/screens/main/enums/nav_item_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WBottomNavItem extends StatelessWidget {
  final BottomNavItemName name;
  final String title;
  final String icon;
  final ValueChanged<BottomNavItemName> onTap;
  final bool isActive;

  const WBottomNavItem({
    super.key,
    required this.name,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return WScale(
      onTap: () => onTap(name),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                  switch (isActive) {
                    (true) => AppColors.deepBlue,
                    (false) => AppColors.grey,
                  },
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: switch (isActive) {
                        (true) => AppColors.deepBlue,
                        (false) => AppColors.grey,
                      },
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
