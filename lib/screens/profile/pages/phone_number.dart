import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/bloc/authentication/authentication_bloc.dart';
import 'package:drugpromotion/core/widgets/app_bar/app_bar.dart';
import 'package:drugpromotion/core/widgets/text_field/text_field.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneNumberPage extends StatefulWidget {
  const PhoneNumberPage({super.key});

  @override
  State<PhoneNumberPage> createState() => _PhoneNumberPageState();
}

class _PhoneNumberPageState extends State<PhoneNumberPage> {
  late TextEditingController phoneController;

  @override
  void initState() {
    final user = context.read<AuthenticationBloc>().state.user;

    phoneController = TextEditingController(text: user.phoneNumber);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WAppBar(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Text(
          AppLocalization.current.phone_number,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.blackish,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: WTextFormField(
              isDisabled: true,
              label: AppLocalization.current.phone_number,
              controller: phoneController,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
