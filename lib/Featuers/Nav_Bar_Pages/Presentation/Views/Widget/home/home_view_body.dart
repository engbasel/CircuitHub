import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/home/AIwidgetHelper.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/home/graid_view_cont.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/home/home_card_swiper.dart';
import 'package:store/constans.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kHorizintalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            HomeCardSwiper(size: size),
            const Text(
              'Categories',
              style: AppStyles.styleSemiBold24,
            ),
            const SizedBox(height: 20),
            const GraidViewCont(),
            const SizedBox(height: 20),

            // AI Assistant Section
            const Text(
              'AI Assistant',
              style: AppStyles.styleSemiBold24,
            ),
            const SizedBox(height: 10),
            const AIwidgetHelper(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
