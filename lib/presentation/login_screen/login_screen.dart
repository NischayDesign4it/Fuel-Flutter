
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nischay_s_application2/core/app_export.dart';
import 'package:nischay_s_application2/widgets/custom_outlined_button.dart';
import 'package:nischay_s_application2/widgets/custom_text_form_field.dart';
import 'package:nischay_s_application2/presentation/entry_screen/entry_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key})
      : super(
          key: key,
        );

  FocusNode emailFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> loginUser(BuildContext context, String email, String password) async {
    // Replace 'your_api_endpoint' with your actual API endpoint
    final String apiUrl = 'http://3.93.195.235:8000/log/';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        // Successful login
        // You can handle the response data here
        final responseData = json.decode(response.body);
        print('Login successful: $responseData');

        // Navigate to the home screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EntryScreen()),
        );
      } else {
        // Handle login failure
        print('Login failed. Status code: ${response.statusCode}');
        // You can show an error message or handle it in a way that fits your app

        // Show a Snackbar with an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Incorrect email or password. Please try again.'),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e) {
      // Handle exceptions
      print('Error during login: $e');
      // You can show an error message or handle it in a way that fits your app

      // Show a Snackbar with an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('An error occurred. Please try again later.',
          style: TextStyle(color: Colors.white),),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true, // Set to true to automatically resize the body when the keyboard appears
        body: GestureDetector(
          onTap: () {
            // Handle tapping outside the keyboard to dismiss it
            FocusScope.of(context).unfocus();
          },
          child: ListView(
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
            child: Form(
              key: _formKey,
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(
                  horizontal: 9.h,
                  vertical: 13.v,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 41.v),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 50.h,
                        right: 106.h,
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
                    SizedBox(height: 20.v),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: 59.v,
                        width: 282.h,
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 1.v),
                                child: SizedBox(
                                  width: 282.h,
                                  child: Divider(),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(left: 70.h),
                                child: Text(
                                  "Ether ",
                                  style: theme.textTheme.displayMedium,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 7.v),
                    Padding(
                      padding: EdgeInsets.only(left: 81.h),
                      child: Text(
                        "vst fuel management inc.",
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                    SizedBox(height: 53.v),
                    Text(
                      "login",
                      style: theme.textTheme.titleLarge,
                    ),
                    SizedBox(height: 22.v),
                    Padding(
                      padding: EdgeInsets.only(right: 18.h),
                      child: CustomTextFormField(
                        controller: emailController,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 34.v),
                    Padding(
                      padding: EdgeInsets.only(right: 18.h),
                      child: CustomTextFormField(
                        controller: passwordController,
                        hintText: "Password",
                        textInputAction: TextInputAction.done,
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,

                      ),
                    ),
                    SizedBox(height: 24.v),
                    Text(
                      "forgot password",
                      style: theme.textTheme.bodySmall!.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(height: 57.v),
                    CustomOutlinedButton(
                      width: 176.h,
                      text: "login",
                      margin: EdgeInsets.only(right: 4.h),
                      buttonStyle: CustomButtonStyles.none,
                      decoration:
                      CustomButtonStyles.gradientIndigoACcToIndigoACcDecoration,

                      alignment: Alignment.centerRight,
                      onPressed: () {
                        // Validate the form before navigating
                        if (_formKey.currentState?.validate() ?? false) {
                          loginUser(context, emailController.text, passwordController.text);

                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          ]
        ),
      )
      ),
    );
  }
}