import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/home/CategoryDetailsView.dart';

class CategoryHomeWidget extends StatelessWidget {
  final String image, name;
  final Color iconColorDark;
  final Color iconColorWith;

  const CategoryHomeWidget({
    super.key,
    required this.image,
    required this.name,
    required this.iconColorDark,
    required this.iconColorWith,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryDetailsView(categoryName: name),
          ),
        );
      },
      child: Column(
        children: [
          SvgPicture.asset(
            image,
            color: isDarkTheme ? iconColorDark : iconColorWith,
            height: 50,
            width: 50,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: AppStyles.styleMedium14,
          )
        ],
      ),
    );
  }
}
