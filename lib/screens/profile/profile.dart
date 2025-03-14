import 'package:drugpromotion/assets/assets.dart';
import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:drugpromotion/screens/profile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: NestedScrollView(
        headerSliverBuilder: (_, isExpanded) => [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            expandedHeight: kToolbarHeight + 160.h,
            surfaceTintColor: Colors.white,
            title: Text(
              AppLocalization.current.profile,
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: AppColors.blackish,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            actions: [
              WScale(
                onTap: () {
                  Navigator.of(context).pushNamed(RouteNames.notifications);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Icon(
                    Icons.notifications_none_outlined,
                    size: 24.w,
                    color: AppColors.deepBlue,
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0XFFF7F7F8),
                    ),
                    child: SizedBox(
                      width: 96.w,
                      height: 96.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 36.w),
                        child: SvgPicture.asset(AppAssets.addCircle),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  WScale(
                    onTap: () {},
                    child: Text(
                      AppLocalization.current.add_avatar,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.deepBlue,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ],
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          children: [
            ProfileItem(
              title: AppLocalization.current.username,
              icon: AppAssets.profile,
              onTap: () {},
            ),
            ProfileItem(
              title: AppLocalization.current.phone_number,
              icon: AppAssets.phone,
              onTap: () {},
            ),
            ProfileItem(
              hasDivider: false,
              title: AppLocalization.current.email,
              icon: AppAssets.email,
              onTap: () {},
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: ProfileItem(
                hasDivider: false,
                title: AppLocalization.current.order_history,
                icon: AppAssets.history,
                onTap: () {},
              ),
            ),
            ProfileItem(
              title: AppLocalization.current.notifications,
              icon: AppAssets.notification,
              onTap: () {
                Navigator.of(context).pushNamed(RouteNames.notifications);
              },
            ),
            ProfileItem(
              title: AppLocalization.current.language,
              icon: AppAssets.language,
              onTap: () {},
            ),
            ProfileItem(
              hasDivider: false,
              title: AppLocalization.current.help,
              icon: AppAssets.help,
              onTap: () {},
            ),
            SizedBox(height: 8.h),
            ProfileItem(
              hasDivider: false,
              textColor: Color(0XFFEF5E50),
              title: AppLocalization.current.logout,
              icon: AppAssets.logout,
              onTap: () {},
            ),
            SizedBox(height: 12.h),
            Text(
              'Version 1.0.0',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
