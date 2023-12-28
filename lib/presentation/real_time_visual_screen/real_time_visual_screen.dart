import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nischay_s_application2/core/app_export.dart';
import 'package:nischay_s_application2/presentation/entry_screen/entry_screen.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:http/http.dart' as http;


import '../../theme/theme_helper.dart';
import '../../widgets/custom_outlined_button.dart';

// Replace this with your actual API URL
const String apiUrl = 'http://3.93.195.235:8000/pump-list/';

class RealTimeVisualScreen extends StatefulWidget {
  final String vehicleNumber;


  const RealTimeVisualScreen({Key? key, required this.vehicleNumber}) : super(key: key);

  @override
  _RealTimeVisualScreenState createState() => _RealTimeVisualScreenState();
}


class _RealTimeVisualScreenState extends State<RealTimeVisualScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isTransactionComplete = false;
  double quantityValue = 0.0; // Change to double

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);

    // Start checking pump status when the screen is loaded
    _checkPumpStatusContinuously();
  }

  Future<void> _checkPumpStatusContinuously() async {
    while (!_isTransactionComplete) {
      // Call your API to get vehicle details
      Map<String, dynamic> vehicleDetails = await getVehicleDetails();

      // Extract quantity from the response
      dynamic rawQuantity = vehicleDetails['quantity'];

      // Check if the quantity is an int or double and handle accordingly
      if (rawQuantity is int) {
        setState(() {
          quantityValue = rawQuantity.toDouble();
        });
      } else if (rawQuantity is double) {
        setState(() {
          quantityValue = rawQuantity;
        });
      }
      // Print the quantityValue to the console
      print('Quantity Value: $quantityValue');



      // Call your API to get pump status
      bool pumpStatus = await checkPumpStatus();

      // Check if the pump status is false
      if (!pumpStatus) {
        // Show popup or perform any action indicating transaction complete
        _showTransactionCompletePopup(context);
        // Set _isTransactionComplete to true to stop the continuous checking
        setState(() {
          _isTransactionComplete = true;
        });
      }

      // Wait for a delay before the next API call
      await Future.delayed(Duration(milliseconds: 10));
    }
  }


  Future<Map<String, dynamic>> getVehicleDetails() async {
    try {
      final response = await http.get(Uri.parse('http://3.93.195.235:8000/get-vehicle/${widget.vehicleNumber}'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);

        // Check if the response is a non-empty map
        if (responseData.isNotEmpty) {
          return responseData;
        } else {
          // Handle the case when the response does not match the expected structure
          return {'quantity': 0.0};
        }
      }

      // Handle other status codes if needed
      return {'quantity': 0.0};
    } catch (e) {
      print('Error getting vehicle details: $e');
      // Handle errors here, return a default value
      return {'quantity': 0.0};
    }
  }
  Future<bool> checkPumpStatus() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);

        // Check if the response is a non-empty list and extract 'pumpStatus'
        if (responseData.isNotEmpty && responseData[0] is Map<String, dynamic>) {
          return responseData[0]['pumpStatus'] as bool;
        } else {
          // Handle the case when the response does not match the expected structure
          return false;
        }
      }

      // Handle other status codes if needed
      return false;
    } catch (e) {
      print('Error checking pump status: $e');
      // Handle errors here, return false or throw an exception
      return false;
    }
  }



  void _showTransactionCompletePopup(BuildContext context) {
    // Implement your logic to show a popup indicating transaction complete
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Transaction Complete'),
        titleTextStyle: theme.textTheme.headlineSmall,
        content: Text('The transaction is complete.'),
        contentTextStyle: theme.textTheme.bodyLarge ,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => EntryScreen())
              );
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Container(
            width: mediaQueryData.size.width,
            height: mediaQueryData.size.height,
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgRealTimeVisual,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 29.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 55.v),
                  _buildTwentyOne(context, quantityValue),
                  SizedBox(height: 89.v),
                  Text(
                    "real-time dispensing",
                    style: theme.textTheme.titleMedium,
                  ),
                  SizedBox(height: 38.v),
                  CustomOutlinedButton(
                    width: 176.h,
                    text: "complete",
                    buttonStyle: CustomButtonStyles.none,
                    decoration: CustomButtonStyles.gradientIndigoACcToIndigoACcDecoration,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EntryScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTwentyOne(BuildContext context, quantityValue) {
 //   double? quantityValue;
    try {
      quantityValue = double.parse(quantityValue.toString());
    } catch (e) {
      quantityValue = 0.0; // Handle invalid double values
    }

    if (quantityValue == null) {
      return Container(); // If parsing fails, show an empty container
    }

    double quantityPercentage = quantityValue / 100.0;
    double remainingPercentage = 1.0 - quantityPercentage;

    return SingleChildScrollView(
      child: SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 318,
              height: 310,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 25.0,
                    spreadRadius: -5, // Negative value to make it only outside
                  ),
                ],
                border: Border.all(
                  color: Color(0xF7F7F8),
                  width: 15,
                ),
              ),
              child: ClipOval(
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [Color(0xEEE7FF), Color(0xFF3D3F9C)],
                      [Color(0xE9DFFF), Color(0xFF3D3F9C)],
                      [Color(0x8D98D2), Color(0xFF3D3F9C)],
                      [Color(0xFF3D3F9C), Color(0xFF3D3F9C)]
                    ],
                    durations: [3500, 19440, 10800, 6000],
                    heightPercentages: [
                      remainingPercentage,
                      remainingPercentage,
                      remainingPercentage,
                      remainingPercentage,
                    ],
                  ),
                  size: const Size(double.infinity, double.infinity),
                ),
              ),
            ),
            Positioned(
              bottom: 30.v,
              child: Text(
                quantityValue.toString(),
                style: theme.textTheme.displayLarge,

              ),
            ),
          ],
        ),
      ),
    );
  }





  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
