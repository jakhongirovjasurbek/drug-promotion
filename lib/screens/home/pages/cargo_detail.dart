import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/models/cargo.dart';
import 'package:drugpromotion/core/models/order.dart';
import 'package:drugpromotion/core/widgets/app_bar/app_bar.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:drugpromotion/screens/home/widgets/cargo_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CargoDetail extends StatefulWidget {
  final CargoModel cargo;

  const CargoDetail({
    super.key,
    required this.cargo,
  });

  @override
  State<CargoDetail> createState() => _CargoDetailState();
}

class _CargoDetailState extends State<CargoDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: WAppBar(
        preferredSize: Size.fromHeight(kToolbarHeight),
        actions: [CargoBadge(status: widget.cargo.cargoStatus)],
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocalization.current.order_details,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.blackish,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
            ),
            Text(
              '#${widget.cargo.cargoId}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                'The task name may be long and not fit in one line',
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: AppColors.blackish,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            SliverToBoxAdapter(child: Divider()),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) {
                  final order = widget.cargo.orders[index];

                  return OrderItem(order: order);
                },
                childCount: widget.cargo.orders.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final OrderModel order;

  const OrderItem({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 8.h,
      ),
      margin: EdgeInsets.fromLTRB(0, 0, 0, 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.whitish,
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            order.client,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
          ),
          SizedBox(height: 4.h),
          Text(
            order.address,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
          ),
          SizedBox(height: 8.h),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Clipboard.setData(ClipboardData(text: order.clientPhone));
            },
            child: Row(
              children: [
                Icon(
                  Icons.copy,
                  size: 18,
                ),
                SizedBox(width: 8.w),
                Text(
                  '${AppLocalization.current.phone_number}: ${order.clientPhone}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4.h,
              horizontal: 8.w,
            ),
            decoration: BoxDecoration(
              color: const Color(0XFFEEF4FD),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              order.isDelivered
                  ? AppLocalization.current.delivered
                  : AppLocalization.current.beingFormed,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.deepBlue,
                  ),
            ),
          ),
          if (order.isDelivered) ...[
            SizedBox(height: 8.h),
            Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0XFFF7F7F8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    child: Text(
                      '${AppLocalization.current.distance}  ≈${order.distance}km',
                    ),
                  ),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0XFFF7F7F8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    child: Text(
                      '${AppLocalization.current.driving_time}  ≈${order.time}m',
                    ),
                  ),
                ),
              ],
            ),
            Text(
              '${order.images}',
            ),
          ],
        ],
      ),
    );
  }
}
