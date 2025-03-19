import 'package:flutter/material.dart';
import 'package:store/Core/Services/shared_preferences_sengleton.dart';
import 'package:store/Featuers/authUseingProvider/login.dart';

import 'package:store/Featuers/splash/presentation/widgets/SplashViewBody.dart';
import 'package:store/constans.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  static const String routeName = 'SplashView';

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _navigateToOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: AppColors.darkScaffoldColor,
      body: SplashViewBody(),
    );
  }

  /// Navigate to the onboarding screen after a delay of 3 seconds.
  void _navigateToOnboarding() {
    var IsOnBoardingViewSeenvalue = Prefs.getBool(
      kIsOnBoardingViewSeen,
      true,
    );

    if (IsOnBoardingViewSeenvalue == true) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, LoginVeiw.routeName);
        // Navigator.pushReplacementNamed(context, SettingsPage.routeName);
      });
    } else {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, LoginVeiw.routeName);
        // Navigator.pushReplacementNamed(context, SettingsPage.routeName);
      });
    }
  }
}
