import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/models/order.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;

  final bool isLastItem;

  const OrderItem({
    super.key,
    required this.order,
    required this.isLastItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.w,
        vertical: 8.h,
      ),
      margin: EdgeInsets.fromLTRB(0, 0, 0, isLastItem ? 0 : 16.h),
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
            ...order.images.map(
              (image) {
                return Container(
                  height: 150.h,
                  clipBehavior: Clip.hardEdge,
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Align(
                    child: Image.network(
                      image,
                      width: double.maxFinite,
                      height: 150.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }
}
