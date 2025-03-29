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
  @override
  @override
  Widget build(BuildContext context) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final productId = ModalRoute.of(context)?.settings.arguments as String?;

    if (productId == null || productId.isEmpty) {
      debugPrint("Error: No productId received in ProductDetails!");
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: const Center(child: Text("Product not found!")),
      );
    }

    final getCurrProduct = productProvider.findByProdId(productId);

    if (getCurrProduct == null) {
      debugPrint("Error: No product found with ID: $productId");
      return Scaffold(
        appBar: AppBar(title: const Text("Error")),
        body: Center(child: Text("Product with ID $productId not found!")),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(getCurrProduct.productTitle)),
      body: const Center(child: Text("Product details here...")),
    );
  }
}
