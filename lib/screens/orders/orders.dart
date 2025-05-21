import 'package:camera/camera.dart';
import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/bloc/order/order_bloc.dart';
import 'package:drugpromotion/core/enums/loading_status.dart';
import 'package:drugpromotion/core/models/order.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:drugpromotion/core/widgets/button/button.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:drugpromotion/screens/home/widgets/order_item.dart';
import 'package:drugpromotion/screens/orders/pages/yandex_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      bottomSheet: OrderBottomSheet(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          AppLocalization.current.my_orders,
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
        bottom: TabBar(
          controller: controller,
          onTap: (value) {
            setState(() {});
          },
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              text: AppLocalization.current.map,
            ),
            Tab(
              text: AppLocalization.current.active,
            ),
          ],
        ),
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        buildWhen: (prev, curr) => prev.getStatus != curr.getStatus,
        builder: (context, state) {
          switch (state.getStatus) {
            case LoadingStatus.pure:
              context.read<OrderBloc>().add(OrderGetCargoEvent());

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<OrderBloc>().add(OrderGetCargoEvent());
                },
                child: Center(
                  child: Text('No cargo selected'),
                ),
              );
            case LoadingStatus.loading:
              return Center(child: Text('Cargo is loading'));
            case LoadingStatus.loadSuccess:
              return IndexedStack(
                index: controller.index,
                children: [
                  const YandexMapScreen(),
                  Builder(builder: (context) {
                    final cargo = state.activeCargo!;

                    return CustomScrollView(
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
                        SliverToBoxAdapter(child: SizedBox(height: 300.h)),
                      ],
                    );
                  }),
                ],
              );
            case LoadingStatus.loadFailure:
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<OrderBloc>().add(OrderGetCargoEvent());
                },
                child: Center(
                  child: Text('Cargo failed to load'),
                ),
              );
          }
        },
      ),
    );
  }
}

class OrderBottomSheet extends StatefulWidget {
  const OrderBottomSheet({
    super.key,
  });

  @override
  State<OrderBottomSheet> createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<OrderBottomSheet> {
  bool showBottomSheet = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return Builder(
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => setState(() => showBottomSheet = !showBottomSheet),
                      child: Container(
                        width: 54.w,
                        height: 5.h,
                        margin: EdgeInsets.only(bottom: 8.h, left: 30.w, right: 30.w, top: 16.h),
                        decoration: BoxDecoration(
                          color: Color(0XFFD1D5DB),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                    ),
                    if (state.getStatus.isLoadSuccess && showBottomSheet) ...{
                      Text(
                        state.activeCargo!.description,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.blackish,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      SizedBox(height: 16.h),
                      if (getProperOrder(state.activeCargo!.orders) case OrderModel order) ...[
                        OrderItem(
                          order: order,
                          isLastItem: true,
                        ),
                        SizedBox(height: 16.h),
                        if (state.orderDetails?.status.isDelivering != true)
                          WButton(
                            loading: state.orderStatus.isLoading,
                            onTap: () {
                              context.read<OrderBloc>().add(OrderAcceptEvent(
                                    cargoId: state.activeCargo!.cargoId,
                                    orderId: order.orderId,
                                    rowId: order.rowId,
                                  ));
                            },
                            text: AppLocalization.of(context).accept_order,
                          ),
                        if (state.orderDetails?.status.isDelivering ?? false)
                          WButton(
                            loading: state.orderStatus.isLoading,
                            onTap: () async {
                              final image = await Navigator.of(context).pushNamed(RouteNames.photo) as XFile?;

                              if (image == null) return;

                              context.read<OrderBloc>().add(OrderEndEvent(
                                    image: image,
                                    cargoId: state.activeCargo!.cargoId,
                                    orderId: order.orderId,
                                    rowId: order.rowId,
                                  ));
                            },
                            text: AppLocalization.of(context).complete_order,
                          ),
                        SizedBox(height: 16.h),
                      ],
                    }
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  OrderModel? getProperOrder(List<OrderModel> orders) {
    OrderModel? selectedOrder;

    for (final order in orders) {
      if (!order.isDelivered) {
        selectedOrder = order;
        break;
      }
    }

    return selectedOrder;
  }
}
