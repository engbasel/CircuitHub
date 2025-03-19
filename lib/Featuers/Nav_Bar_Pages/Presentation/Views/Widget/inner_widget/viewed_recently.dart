import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Core/Utils/show_dialog.dart';
import 'package:store/Core/Widget/empty_widget.dart';
import 'package:store/Core/Widget/product_widget.dart';
import 'package:store/constans.dart';
import 'package:store/providers/viewed_prod_provider.dart';

class ViewedRecently extends StatelessWidget {
  const ViewedRecently({super.key});
  static const routeName = 'ViewedRecently';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final viewedRecently = Provider.of<ViewedProdProvider>(context);

    return viewedRecently.getviewedProdItems.isEmpty
        ? EmptyWidget(
            size: size,
            image: Assets.admin_imagesShoppingCart,
            title: 'Your Viewed Recently is empty',
            subtitle:
                'Looks like you haven\'t added anything in your Viewed Recently yet.',
            texButoon: 'Shop Now',
          )
        : Scaffold(
            appBar: AppBar(
              title: AppNameAnimatedText(
                text:
                    'Viewed Recently (${viewedRecently.getviewedProdItems.length})',
                fontSize: 20,
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset(Assets.admin_imagesShoppingCart),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    ShowDialogClass.showDialogClass(
                      context: context,
                      text: 'Remove all items ?',
                      function: () {
                        viewedRecently.clearLocalViewedProd();
                      },
                    );
                  },
                  icon: const Icon(
                    IconlyLight.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            body: DynamicHeightGridView(
              crossAxisCount: 2,
              builder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: kHorizintalPadding),
                  child: ProductWidget(
                      productId: viewedRecently.getviewedProdItems.values
                          .toList()[index]
                          .productId),
                );
              },
              itemCount: viewedRecently.getviewedProdItems.length,
            ),
          );
  }
}
