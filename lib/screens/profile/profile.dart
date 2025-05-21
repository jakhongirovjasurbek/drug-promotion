import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drugpromotion/assets/assets.dart';
import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/bloc/authentication/authentication_bloc.dart';
import 'package:drugpromotion/core/bloc/orders/cargo_bloc.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:drugpromotion/screens/profile/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: NestedScrollView(
        headerSliverBuilder: (_, isExpanded) => [
          SliverAppBar(
            centerTitle: true,
            pinned: true,
            backgroundColor: Colors.white,
            shadowColor: Colors.white,
            expandedHeight: kToolbarHeight + 160.h,
            surfaceTintColor: Colors.white,
            title: Text(
              AppLocalization.current.profile,
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
            flexibleSpace: FlexibleSpaceBar(
              background: UserAvatar(),
            ),
          ),
        ],
        body: ListView(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          children: [
            ProfileItem(
              title: AppLocalization.current.username,
              icon: AppAssets.profile,
              onTap: () => Navigator.of(context).pushNamed(RouteNames.username),
            ),
            ProfileItem(
              title: AppLocalization.current.phone_number,
              icon: AppAssets.phone,
              onTap: () => Navigator.of(context).pushNamed(RouteNames.phoneNumber),
            ),
            ProfileItem(
              hasDivider: false,
              title: AppLocalization.current.email,
              icon: AppAssets.email,
              onTap: () => Navigator.of(context).pushNamed(RouteNames.email),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: ProfileItem(
                hasDivider: false,
                title: AppLocalization.current.order_history,
                icon: AppAssets.history,
                onTap: () => Navigator.of(context).pushNamed(
                  RouteNames.orderHistory,
                  arguments: context.read<CargoBloc>(),
                ),
              ),
            ),
            ProfileItem(
              title: AppLocalization.current.notifications,
              icon: AppAssets.notification,
              onTap: () {
                Navigator.of(context).pushNamed(RouteNames.notifications);
              },
            ),
            ProfileItem(
              title: AppLocalization.current.language,
              icon: AppAssets.language,
              onTap: () => Navigator.of(context).pushNamed(RouteNames.language),
            ),
            // ProfileItem(
            //   hasDivider: false,
            //   title: AppLocalization.current.help,
            //   icon: AppAssets.help,
            //   onTap: () {},
            // ),
            // SizedBox(height: 8.h),
            ProfileItem(
              hasDivider: false,
              textColor: Color(0XFFEF5E50),
              title: AppLocalization.current.logout,
              icon: AppAssets.logout,
              onTap: () {
                context.read<AuthenticationBloc>().add(LogoutRequested());
              },
            ),
            SizedBox(height: 12.h),
            Text(
              'Version 1.0.0',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends StatefulWidget {
  const UserAvatar({
    super.key,
  });

  @override
  State<UserAvatar> createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  XFile? selectedImage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        final user = state.user;

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0XFFF7F7F8),
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: switch (user.image != null && user.image!.isNotEmpty) {
                  (true) => CachedNetworkImage(
                      imageUrl: user.image!,
                      width: 96.w,
                      height: 96.h,
                      fit: BoxFit.cover,
                    ),
                  (false) => selectedImage != null
                      ? Image.file(
                          File(selectedImage!.path),
                          width: 96.w,
                          height: 96.h,
                          fit: BoxFit.cover,
                        )
                      : SizedBox(
                          width: 96.w,
                          height: 96.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 36.w),
                            child: SvgPicture.asset(AppAssets.addCircle),
                          ),
                        ),
                },
              ),
            ),
            SizedBox(height: 16.h),
            WScale(
              onTap: () async {
                final picker = ImagePicker();

                final imageSource = await showModalBottomSheet<ImageSource?>(
                  context: context,
                  isDismissible: true,
                  isScrollControlled: false,
                  builder: (context) {
                    return Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 54.w,
                              height: 5.h,
                              margin: EdgeInsets.only(bottom: 8.h),
                              decoration: BoxDecoration(
                                color: Color(0XFFD1D5DB),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Profile Photo',
                                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                        color: AppColors.blackish,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                WScale(
                                  onTap: Navigator.of(context).pop,
                                  child: Icon(Icons.close),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            WScale(
                              onTap: () => Navigator.pop(context, ImageSource.gallery),
                              child: Row(
                                children: [
                                  Icon(Icons.photo_library_outlined),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Gallery',
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          color: AppColors.blackish,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            WScale(
                              onTap: () => Navigator.pop(context, ImageSource.camera),
                              child: Row(
                                children: [
                                  Icon(Icons.camera_alt),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Camera',
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          color: AppColors.blackish,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );

                if (imageSource != null) {
                  final image = await picker.pickImage(source: imageSource);

                  if (image == null) return;

                  setState(() => selectedImage = image);
                }
              },
              child: Text(
                AppLocalization.current.add_avatar,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.deepBlue,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        );
      },
    );
  }
}
