// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/search_view.dart';

// ignore: must_be_immutable
class CategoreHomeWidget extends StatelessWidget {
  CategoreHomeWidget({
    super.key,
    required this.image,
    required this.name,
    required this.iconColorDark,
    required this.iconColorWith,
  });
  final String image, name;
  Color iconColorDark;
  Color iconColorWith;

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () async {
        await Navigator.pushNamed(
          context,
          SearchView.routeName,
          arguments: name,
        );
      },
      child: Column(
        children: [
          SvgPicture.asset(
            image,
            color: isDarkTheme ? iconColorDark : iconColorWith, // Dynamic color
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
