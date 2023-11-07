import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hop_maldives_admin/animations/entrance_fader.dart';
import 'package:hop_maldives_admin/app_routes.dart';
import 'package:hop_maldives_admin/configs/app.dart';
import 'package:hop_maldives_admin/utils/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _next() {
    final user = FirebaseAuth.instance.currentUser;

    Future.delayed(const Duration(seconds: 2), () {
      if (user == null) {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
      }
    });
  }

  @override
  void initState() {
    _next();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Scaffold(
      body: Center(
        child: EntranceFader(
          offset: const Offset(0, 20),
          duration: const Duration(seconds: 1),
          child: Image.asset(
            StaticAssets.fullLogo,
          ),
        ),
      ),
    );
  }
}
