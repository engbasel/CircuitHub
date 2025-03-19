import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/search_view_body.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Core/Utils/assets.dart';

import 'package:store/providers/product_provider.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const String routeName = 'SearchView';

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      appBar: AppBar(
        title: AppNameAnimatedText(
          text: passedCategory ?? 'Search',
          fontSize: 20,
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(Assets.admin_imagesShoppingCart),
        ),
      ),
      body: const SearchViewBody(),
    );
  }
}
