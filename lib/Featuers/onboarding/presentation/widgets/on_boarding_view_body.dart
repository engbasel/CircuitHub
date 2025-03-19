import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:store/Core/Services/shared_preferences_sengleton.dart';
import 'package:store/Core/Utils/app_colors.dart';
// import 'package:store/Core/Utils/app_colors.dart';
import 'package:store/Core/Widget/custom_botton.dart';
// import 'package:store/Core/Widget/custom_botton.dart';
import 'package:store/Featuers/authUseingProvider/login.dart';
import 'package:store/Featuers/onboarding/presentation/widgets/on_boarding_page_view.dart';
import 'package:store/constans.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  late PageController pageController;
  var currentPage = 0;

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      currentPage = pageController.page!.round();
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Expanded(child: OnBoardingPageview(pageController: pageController)),
        DotsIndicator(
          dotsCount: 2,
          decorator: DotsDecorator(
            // activeColor: AppColors.lightCardColor,
            activeColor: Colors.grey,
            color: currentPage == 1 ? Colors.black : Colors.grey,
            //  AppColors.lightCardColor.withOpacity(.5),
          ),
        ),
        const SizedBox(height: 29),
        Visibility(
          visible: currentPage == 1,
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHorizintalPadding,
            ),
            child: CustomBotton(
              isIconNeeded: true,
              icon: Icons.arrow_forward_outlined,

              // backgroundColor: AppColors.lightCardColor ,
              background: isDarkTheme
                  ? AppColors.lightCardColor
                  : AppColors.darkScaffoldColor, // Dynamic color,
              // kTheme ? Colors.white : Colors.black, // Dynamic color
              // contentColor: AppColors.darkScaffoldColor,
              onPressed: () {
                Prefs.setBool(kIsOnBoardingViewSeen, true);
                Navigator.of(context).pushReplacementNamed(LoginVeiw.routeName);
              },
              text: ' Start Shopping Now', // Updated to "Start Shopping Now"
            ),
          ),
        ),
        const SizedBox(height: 43),
      ],
    );
  }
}
