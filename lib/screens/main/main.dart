import 'package:drugpromotion/assets/assets.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:drugpromotion/screens/home/home.dart';
import 'package:drugpromotion/screens/main/enums/nav_item_name.dart';
import 'package:drugpromotion/screens/main/widgets/nav_item.dart';
import 'package:drugpromotion/screens/orders/orders.dart';
import 'package:drugpromotion/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BottomNavItemName selectedNavItem = BottomNavItemName.home;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedNavItem.index,
        children: [
          HomePage(),
          OrdersPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 0),
              blurRadius: 12,
              color: Colors.black.withAlpha(30),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: SizedBox(
            height: 50.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                WBottomNavItem(
                  name: BottomNavItemName.home,
                  title: AppLocalization.current.home,
                  icon: AppAssets.home,
                  onTap: (value) {
                    setState(() {
                      selectedNavItem = value;
                    });
                  },
                  isActive: selectedNavItem.isHome,
                ),
                WBottomNavItem(
                  name: BottomNavItemName.orders,
                  title: AppLocalization.current.my_orders,
                  icon: AppAssets.myOrders,
                  onTap: (value) {
                    setState(() {
                      selectedNavItem = value;
                    });
                  },
                  isActive: selectedNavItem.isOrders,
                ),
                WBottomNavItem(
                  name: BottomNavItemName.profile,
                  title: AppLocalization.current.profile,
                  icon: AppAssets.profile,
                  onTap: (value) {
                    setState(() {
                      selectedNavItem = value;
                    });
                  },
                  isActive: selectedNavItem.isProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
