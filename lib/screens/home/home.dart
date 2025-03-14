import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:drugpromotion/screens/home/widgets/cargo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: NestedScrollView(
        headerSliverBuilder: (_, __) => [
          SliverAppBar(
            pinned: true,
            elevation: 5,
            shadowColor: Colors.black.withAlpha(70),
            centerTitle: true,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Text(
              AppLocalization.current.home_page,
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
          )
        ],
        body: ListView.separated(
          padding: EdgeInsets.fromLTRB(0, 8.h, 0, 100.h),
          itemBuilder: (context, index) => CargoItem(),
          separatorBuilder: (_, __) => SizedBox(height: 8.h),
          itemCount: 10,
        ),
      ),
    );
  }
}
