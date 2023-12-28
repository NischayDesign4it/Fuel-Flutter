import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/scheduler.dart';
import 'package:nischay_s_application2/theme/theme_helper.dart';
import 'package:nischay_s_application2/routes/app_routes.dart';
import 'package:nischay_s_application2/presentation/launch_screen/launch_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'Ither-Fuel',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: AppRoutes.routes,
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();

      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, AppRoutes.loginScreen);
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: LaunchScreen(), // Your custom screen widget
        ),
      ),
    );
  }
}
