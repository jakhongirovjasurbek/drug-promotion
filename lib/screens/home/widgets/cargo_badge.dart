import 'package:drugpromotion/core/enums/cargo_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CargoBadge extends StatelessWidget {
  final CargoStatus status;

  const CargoBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.h,
        horizontal: 8.w,
      ),
      decoration: BoxDecoration(
        color: switch (status) {
          CargoStatus.beingFormed => const Color(0XFFF7F7F8),
          CargoStatus.readyForLoading => const Color(0XFFF7F7F8),
          CargoStatus.onTheWay => const Color(0XFF00B41E),
          CargoStatus.closed => const Color(0XFF0E0E12),
          CargoStatus.unknown => const Color(0XFFF7F7F8),
        },
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        status.description,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: switch (status) {
                CargoStatus.beingFormed => const Color(0XFF141417),
                CargoStatus.readyForLoading => const Color(0XFF141417),
                _ => Colors.white,
              },
            ),
      ),
    );
  }
}
