import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/search_view.dart';

class CategoreHomeWidget extends StatelessWidget {
  const CategoreHomeWidget(
      {super.key, required this.image, required this.name});
  final String image, name;
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
            color: isDarkTheme ? Colors.white : Colors.black, // Dynamic color
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
