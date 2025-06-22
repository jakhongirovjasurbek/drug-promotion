import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:drugpromotion/assets/assets.dart';
import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/bloc/authentication/authentication_bloc.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

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
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
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
                              onTap: () =>
                                  Navigator.pop(context, ImageSource.gallery),
                              child: Row(
                                children: [
                                  Icon(Icons.photo_library_outlined),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Gallery',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
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
                              onTap: () =>
                                  Navigator.pop(context, ImageSource.camera),
                              child: Row(
                                children: [
                                  Icon(Icons.camera_alt),
                                  SizedBox(width: 8.w),
                                  Text(
                                    'Camera',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
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
