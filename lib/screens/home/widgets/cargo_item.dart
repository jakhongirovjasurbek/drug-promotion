import 'package:drugpromotion/assets/assets.dart';
import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/models/cargo.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:drugpromotion/screens/home/widgets/cargo_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CargoItem extends StatelessWidget {
  final CargoModel cargo;

  const CargoItem({
    super.key,
    required this.cargo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pushNamed(
        RouteNames.cargoDetail,
        arguments: cargo,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '#${cargo.cargoId}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  CargoBadge(status: cargo.cargoStatus),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                cargo.cargoDate,
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
                      cargo.orders.fold('', (sum, order) {
                        return sum.isEmpty
                            ? order.address
                            : '${order.address}, ';
                      }),
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
      ),
    );
  }
}
