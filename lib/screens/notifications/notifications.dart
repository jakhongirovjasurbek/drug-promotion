import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/widgets/app_bar/app_bar.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
