import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/product_details_body.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/providers/product_provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});
  static const routeName = 'product_details';

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final getCurrProduct = productProvider.findByProdId(productId);

    return getCurrProduct == null
        ? const SizedBox.shrink()
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const AppNameAnimatedText(
                text: 'CircuitHub',
                fontSize: 24,
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.canPop(context) ? Navigator.pop(context) : null;
                },
                icon: const Icon(
                  IconlyLight.arrowLeft2,
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    IconlyLight.bag2,
                  ),
                ),
              ],
            ),
            body: ProductDetailsBody(
              productProvider: productProvider,
              getCurrProduct: getCurrProduct,
              productId: productId,
            ),
          );
  }
}
