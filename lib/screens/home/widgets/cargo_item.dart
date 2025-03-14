import 'package:drugpromotion/assets/assets.dart';
import 'package:drugpromotion/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CargoItem extends StatelessWidget {
  const CargoItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '#9430034',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'The task name may be long and not fit in one line',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.blackish,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            Divider(
              color: AppColors.whitish,
              height: 25.h,
            ),
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0XFFF7F7F8),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 8.h,
                    ),
                    child: SvgPicture.asset(AppAssets.location),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Улица Шахризабская, дом 5 Подбрось монетку, Орел Решка... ',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.blackish,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
