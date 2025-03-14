import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:drugpromotion/screens/home/widgets/cargo_item.dart';
import 'package:drugpromotion/screens/orders/pages/yandex_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage>
    with SingleTickerProviderStateMixin {
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
      body: IndexedStack(
        index: controller.index,
        children: [
          const YandexMapScreen(),
          ListView.separated(
            padding: EdgeInsets.fromLTRB(0, 8.h, 0, 100.h),
            itemBuilder: (context, index) => CargoItem(),
            separatorBuilder: (_, __) => SizedBox(height: 8.h),
            itemCount: 10,
          ),
        ],
      ),
    );
  }
}
