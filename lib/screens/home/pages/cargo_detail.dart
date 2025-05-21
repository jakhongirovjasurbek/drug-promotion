import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/bloc/orders/cargo_bloc.dart';
import 'package:drugpromotion/core/enums/cargo_status.dart';
import 'package:drugpromotion/core/models/cargo.dart';
import 'package:drugpromotion/core/widgets/app_bar/app_bar.dart';
import 'package:drugpromotion/core/widgets/button/button.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:drugpromotion/screens/home/widgets/cargo_badge.dart';
import 'package:drugpromotion/screens/home/widgets/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<CargoBloc, CargoState>(
      builder: (context, state) {
        final cargo = state.cargos.firstWhere(
          (item) => item.cargoId == widget.cargo.cargoId,
          orElse: () => widget.cargo,
        );

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: WAppBar(
            preferredSize: Size.fromHeight(kToolbarHeight),
            actions: [CargoBadge(status: cargo.cargoStatus)],
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
                  '#${cargo.cargoId}',
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
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    cargo.description,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: AppColors.blackish,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverToBoxAdapter(child: Divider()),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverToBoxAdapter(
                  child: Row(
                    children: [
                      Text(
                        AppLocalization.of(context).orders,
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                              color: AppColors.blackish,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(width: 8.w),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32.r),
                          color: AppColors.blackish,
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          child: Text(
                            'x${cargo.orders.length}',
                            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      final order = cargo.orders[index];

                      return OrderItem(
                        order: order,
                        isLastItem: index == cargo.orders.length - 1,
                      );
                    },
                    childCount: cargo.orders.length,
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: switch (cargo.cargoStatus.isReadyForLoading) {
            (true) => BlocConsumer<CargoBloc, CargoState>(
                listener: (context, state) {
                  if (state.cargoStatus.isLoadFailure) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        dismissDirection: DismissDirection.horizontal,
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        content: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                            child: Text(state.error!),
                          ),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) => WButton(
                  margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  loading: state.cargoStatus.isLoading,
                  onTap: () {
                    context.read<CargoBloc>().add(CargoChangeStatusEvent(
                          cargoId: cargo.cargoId,
                          status: CargoStatus.onTheWay,
                        ));
                  },
                  text: AppLocalization.of(context).deliver,
                ),
              ),
            (false) => null,
          },
        );
      },
    );
  }
}
