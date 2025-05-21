import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/assets/constants.dart';
import 'package:drugpromotion/core/helpers/locale.dart';
import 'package:drugpromotion/core/widgets/app_bar/app_bar.dart';
import 'package:drugpromotion/core/widgets/button/button.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class LanguagesPage extends StatefulWidget {
  const LanguagesPage({super.key});

  @override
  State<LanguagesPage> createState() => _LanguagesPageState();
}

class _LanguagesPageState extends State<LanguagesPage> {
  String? selectedLanguage;

  @override
  void initState() {
    selectedLanguage = Intl().locale;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WAppBar(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Text(
          AppLocalization.current.language,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.blackish,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            RadioMenuButton<String>(
              value: AppConstants.uzbekLanguage,
              groupValue: selectedLanguage,
              onChanged: selectLanguage,
              child: Text(AppLocalization.current.uzbek),
            ),
            const Divider(),
            RadioMenuButton<String>(
              value: AppConstants.russianLanguage,
              groupValue: selectedLanguage,
              onChanged: selectLanguage,
              child: Text(AppLocalization.current.russian),
            ),
            const Divider(),
            RadioMenuButton<String>(
              value: AppConstants.englishLanguage,
              groupValue: selectedLanguage,
              onChanged: selectLanguage,
              child: Text(AppLocalization.current.english),
            ),
          ],
        ),
      ),
      bottomNavigationBar: WButton(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        text: AppLocalization.current.save,
        onTap: () async {
          if (selectedLanguage != null) context.read<AppLocaleNotifier>().setLocale(selectedLanguage!);

          if (mounted) Navigator.of(context).pop();
        },
      ),
    );
  }

  void selectLanguage(String? value) {
    setState(() {
      selectedLanguage = value;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
