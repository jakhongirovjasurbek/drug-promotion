enum BottomNavItemName {
  home,
  orders,
  profile;

  bool get isHome => this == home;

  bool get isOrders => this == orders;

  bool get isProfile => this == profile;
}
