import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/bloc/notifications/notifications_bloc.dart';
import 'package:drugpromotion/core/widgets/app_bar/app_bar.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: WAppBar(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Text(
          AppLocalization.current.notifications,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.blackish,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<NotificationsBloc>().add(const NotificationsEvent$Get());
        },
        child: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            if (state.getStatus.isPure) {
              context
                  .read<NotificationsBloc>()
                  .add(const NotificationsEvent$Get());

              return SizedBox();
            }

            if (state.getStatus.isLoading) {
              return const Center(child: CupertinoActivityIndicator());
            }

            if (state.getStatus.isLoadFailure) {
              return const SizedBox();
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemCount: state.notifications.length,
              itemBuilder: (_, index) {
                final notification = state.notifications[index];

                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        notification.heading,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.blackish,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        notification.text,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      SizedBox(height: 4.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          notification.date,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: AppColors.grey,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
