import 'dart:io';

import 'package:camera/camera.dart';
import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/routes/route_names.dart';
import 'package:drugpromotion/core/widgets/app_bar/app_bar.dart';
import 'package:drugpromotion/core/widgets/button/button.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedImagesPage extends StatefulWidget {
  const SavedImagesPage({super.key});

  @override
  State<SavedImagesPage> createState() => _SavedImagesPageState();
}

class _SavedImagesPageState extends State<SavedImagesPage> {
  List<XFile> images = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WAppBar(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Text(
          AppLocalization.current.orders,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.blackish,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
        ),
      ),
      bottomNavigationBar: WButton(
        margin: EdgeInsets.all(16.w),
        onTap: () {
          Navigator.of(context).pop(images);
        },
        text: AppLocalization.current.send,
      ),
      body: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        children: [
          ...images.map(
            (image) => Padding(
              padding: EdgeInsets.all(12.w),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16.r),
                child: Image.file(
                  File(image.path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          WScale(
            onTap: () async {
              final image = await Navigator.of(context)
                  .pushNamed(RouteNames.photo) as XFile?;

              if (image == null) return;

              setState(() {
                images.add(image);
              });
            },
            child: Container(
              margin: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.camera_rounded,
                size: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
