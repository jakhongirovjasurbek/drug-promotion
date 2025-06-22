import 'dart:io';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:drugpromotion/assets/colors.dart';
import 'package:drugpromotion/core/widgets/button/button.dart';
import 'package:drugpromotion/core/widgets/scale/scale.dart';
import 'package:drugpromotion/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? cameraController;

  XFile? picture;

  @override
  void initState() {
    availableCameras().then((cameras) {
      setState(() => cameraController =
          CameraController(cameras[0], ResolutionPreset.max));
    });
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Builder(builder: (context) {
        if (cameraController == null) {
          return Center(child: CupertinoActivityIndicator());
        }

        return FutureBuilder(
          future: cameraController!.initialize(),
          builder: (context, snapshot) {
            if (snapshot.hasError) return SizedBox();

            return switch (snapshot.connectionState) {
              ConnectionState.done => Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: switch (picture != null) {
                        (true) => SizedBox.expand(
                            child: Image.file(
                              File(picture!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        (false) => Center(
                            child: CameraPreview(cameraController!),
                          ),
                      },
                    ),
                    if (picture == null) const CameraOverlay(),
                    Positioned(
                      left: 0,
                      top: 0,
                      right: 0,
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                              12.w,
                              MediaQuery.of(context).padding.top + 12.h,
                              12.w,
                              12.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                WScale(
                                  onTap: Navigator.of(context).pop,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppColors.whitish,
                                    size: 20.w,
                                  ),
                                ),
                                Text(
                                  'Photo',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                SizedBox(width: 20.w),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (picture == null)
                      Positioned(
                        left: MediaQuery.of(context).size.width / 2 - 38.w,
                        bottom: MediaQuery.of(context).padding.bottom + 8.h,
                        child: WScale(
                          onTap: () async {
                            try {
                              final snapshot =
                                  await cameraController!.takePicture();

                              setState(() => picture = snapshot);
                            } catch (error) {
                              debugPrint('$error');
                            }
                          },
                          child: Container(
                            width: 76.w,
                            height: 76.w,
                            padding: EdgeInsets.all(5.w),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 3.w,
                                color: Colors.white,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    if (picture != null)
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 68.h + MediaQuery.of(context).padding.bottom,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: WScale(
                                    onTap: () {
                                      setState(() => picture = null);
                                    },
                                    child: Text(
                                      AppLocalization.of(context).retake,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                            color: AppColors.blackish,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: WButton(
                                  height: 44.h,
                                  width: 165.w,
                                  onTap: () =>
                                      Navigator.of(context).pop(picture),
                                  text: AppLocalization.of(context).send,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              _ => SizedBox(),
            };
          },
        );
      }),
    );
  }

  @override
  void dispose() {
    cameraController!.dispose();

    super.dispose();
  }
}

class CornerBorderPainter extends CustomPainter {
  final double borderLength;
  final double borderWidth;
  final Color color;

  CornerBorderPainter({
    required this.borderLength,
    required this.borderWidth,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    // Top-left corner
    canvas.drawLine(Offset(0, 0), Offset(borderLength, 0), paint);
    canvas.drawLine(Offset(0, 0), Offset(0, borderLength), paint);

    // Top-right
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width - borderLength, 0), paint);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width, borderLength), paint);

    // Bottom-left
    canvas.drawLine(
        Offset(0, size.height), Offset(borderLength, size.height), paint);
    canvas.drawLine(
        Offset(0, size.height), Offset(0, size.height - borderLength), paint);

    // Bottom-right
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width - borderLength, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width, size.height - borderLength), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CameraOverlay extends StatelessWidget {
  final double borderLength;
  final double borderWidth;
  final double scanAreaWidth;
  final double scanAreaHeight;

  const CameraOverlay({
    super.key,
    this.borderLength = 30,
    this.borderWidth = 4,
    this.scanAreaWidth = 300,
    this.scanAreaHeight = 200,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;

        final double left = (screenWidth - scanAreaWidth) / 2;
        final double top = (screenHeight - scanAreaHeight) / 2;

        return Stack(
          children: [
            // Dark background
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
                BlendMode.srcOut,
              ),
              child: Stack(
                children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  Positioned(
                    left: left,
                    top: top,
                    child: Container(
                      width: scanAreaWidth,
                      height: scanAreaHeight,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // White corner borders
            Positioned(
              left: left,
              top: top,
              child: CustomPaint(
                size: Size(scanAreaWidth, scanAreaHeight),
                painter: CornerBorderPainter(
                  borderLength: borderLength,
                  borderWidth: borderWidth,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
