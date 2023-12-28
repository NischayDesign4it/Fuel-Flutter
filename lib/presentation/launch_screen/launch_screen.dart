import 'package:flutter/material.dart';
import 'package:nischay_s_application2/core/app_export.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Container(
          width: mediaQueryData.size.width,
          height: mediaQueryData.size.height,
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgLaunchScreen,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
              left: 37.h,
              top: 76.v,
              right: 37.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 34.h,
                    right: 66.h,
                  ),
                  child: Row(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgVector,
                        height: 81.v,
                        width: 52.h,
                        margin: EdgeInsets.only(
                          top: 89.v,
                          bottom: 96.v,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgVectorBlack900,
                        height: 165.v,
                        width: 33.h,
                        margin: EdgeInsets.only(
                          left: 29.h,
                          top: 50.v,
                          bottom: 52.v,
                        ),
                      ),
                      Spacer(),
                      CustomImageView(
                        imagePath: ImageConstant.imgVectorBlack900268x34,
                        height: 268.v,
                        width: 34.h,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.v),
                Padding(
                  padding: EdgeInsets.only(left: 74.h),
                  child: Text(
                    "Ether ",
                    style: theme.textTheme.displayMedium,
                  ),
                ),
                Divider(
                  indent: 4.h,
                ),
                SizedBox(height: 8.v),
                Padding(
                  padding: EdgeInsets.only(left: 53.h),
                  child: Text(
                    "vst fuel management inc.",
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
