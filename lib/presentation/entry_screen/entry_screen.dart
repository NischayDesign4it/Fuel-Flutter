import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nischay_s_application2/core/app_export.dart';
import 'package:nischay_s_application2/presentation/login_screen/login_screen.dart';
import 'package:nischay_s_application2/presentation/real_time_visual_screen/real_time_visual_screen.dart';
import 'package:nischay_s_application2/widgets/custom_outlined_button.dart';

class EntryScreen extends StatefulWidget {
  EntryScreen({Key? key}) : super(key: key);

  @override
  _EntryScreenState createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  TextEditingController vehicleNumberController = TextEditingController();
  TextEditingController odometerController = TextEditingController(); // Add this line
  FocusNode vehicleNumberFocusNode = FocusNode();
  FocusNode odometerFocusNode = FocusNode(); // Add this line

  @override
  void dispose() {
    vehicleNumberFocusNode.dispose();
    odometerFocusNode.dispose(); // Add this line
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            Container(
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
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 53.v,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 21.v),
                    Text(
                      "Select Vehicle",
                      style: theme.textTheme.displayMedium,
                    ),
                    SizedBox(height: 96.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: Text(
                          "Enter Vehicle Number ",
                          style: CustomTextStyles.headlineSmallBlack900,
                        ),
                      ),
                    ),
                    SizedBox(height: 26.v),
                    TextField(
                      controller: vehicleNumberController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: appTheme.whiteA700,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.h),
                          borderSide: BorderSide(
                            color: appTheme.black900,
                            width: 1.h,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.h),
                          borderSide: BorderSide(
                            color: appTheme.black900,
                            width: 1.h,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10.h),
                      ),
                    ),
                    SizedBox(height: 26.v),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: Text(
                          "Enter Odometer Reading",
                          style: CustomTextStyles.headlineSmallBlack900,
                        ),
                      ),
                    ),
                    SizedBox(height: 26.v),
                    TextField(
                      controller: odometerController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: appTheme.whiteA700,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.h),
                          borderSide: BorderSide(
                            color: appTheme.black900,
                            width: 1.h,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.h),
                          borderSide: BorderSide(
                            color: appTheme.black900,
                            width: 1.h,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10.h),
                      ),
                    ),
                    SizedBox(height: 55.v),
                    CustomOutlinedButton(
                      width: 176.h,
                      text: "continue",
                      buttonStyle: CustomButtonStyles.none,
                      decoration: CustomButtonStyles
                          .gradientIndigoACcToIndigoACcDecoration,
                      onPressed: () {
                        checkVehicleAndNavigate(
                            context, vehicleNumberController.text,
                            odometerController.text);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20.v,
              left: 20.h,
              child: CustomOutlinedButton(
                height: 34.v,
                width: 101.h,
                text: "<- back",
                buttonStyle: CustomButtonStyles.outlineBlack,
                buttonTextStyle: theme.textTheme.titleLarge!,
                alignment: Alignment.centerLeft,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }





  Future<void> checkVehicleAndNavigate(
      BuildContext context, String vehicleNumber, String odometer) async {
    final String getVehicleApiUrl = 'http://3.93.195.235:8000/Check-vehicle/';
    final String postVehicleApiUrl = 'http://3.93.195.235:8000/pump-status/';

    try {
      // Initial vehicle check
      final response = await http.post(
        Uri.parse(getVehicleApiUrl),
        body: {
          'vehicleNumber': vehicleNumber,
        },
      );



      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('Vehicle successful: $responseData');


        // Initial post request
        await http.post(
          Uri.parse(postVehicleApiUrl),
          body: {
            'pumpNumber': "001",
            'vehicleNumber': vehicleNumber,
            'odometer': (int.tryParse(odometer) ?? 0).toString(),
            'pumpStatus': 'true',
          },
        );

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RealTimeVisualScreen(vehicleNumber: vehicleNumber,),
          ),
        );

          // Send data to dispense API
          final Response = await http.post(
            Uri.parse(getVehicleApiUrl),
            body: {
              'vehicleNumber': vehicleNumber,
            },
          );

          if (Response.statusCode == 200) {
            // Handle the response as needed
            final data = json.decode(Response.body);
            print('data: $data ');

            // Optionally, send updated data to the post API
            await http.post(
              Uri.parse(postVehicleApiUrl),
              body: {
                'pumpNumber': "001",
                'vehicleNumber': vehicleNumber,
                'odometer': (int.tryParse(odometer) ?? 0).toString(),
                'pumpStatus': 'true',
              },
            );
          } else {
            print('Failed to get dispense data. Status code: ${Response.statusCode}');
          }
      } else {
        print('Vehicle check failed. Status code: ${response.statusCode}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Incorrect vehicle number. Please enter a valid vehicle number.',
              style: TextStyle(color: Colors.white),
            ),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      print('Error during vehicle check: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'An error occurred during vehicle check. Please try again later.',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

}