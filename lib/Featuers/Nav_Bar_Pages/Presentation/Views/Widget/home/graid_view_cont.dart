import 'package:flutter/material.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/home/categore_home_widget.dart';
import 'package:store/constans.dart';

class GraidViewCont extends StatelessWidget {
  const GraidViewCont({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: List.generate(
        // CategoryList.
        AppConstans.categoriesListModel.length,
        (index) {
          return CategoreHomeWidget(
            iconColorDark: AppConstans.categoriesListModel[index].colorDark,
            iconColorWith: AppConstans.categoriesListModel[index].colorLight,
            image: AppConstans.categoriesListModel[index].image,
            name: AppConstans.categoriesListModel[index].name,
          );
        },
      ),
    );
  }
}
