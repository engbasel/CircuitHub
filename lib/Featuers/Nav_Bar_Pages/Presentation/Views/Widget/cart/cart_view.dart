import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Core/Utils/loading_manager.dart';
import 'package:store/Core/Utils/my_app_method.dart';
import 'package:store/Core/Utils/show_dialog.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/cart/cart_view_body.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/cart/chechout.dart';

import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/product_provider.dart';
import 'package:store/providers/user_provider.dart';
import 'package:uuid/uuid.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    return Scaffold(
      bottomSheet: Checkout(
        function: () async {
          await placeOrder(
            cartProvider: cartProvider,
            productProvider: productProvider,
            userProvider: userProvider,
          );
        },
      ),
      appBar: AppBar(
        title: AppNameAnimatedText(
          text: 'Shopping basket (${cartProvider.cartItems.length})',
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
                function: () async {
                  // cartProvider.clearLocalCart();
                  await cartProvider.clearCartFromFirebase();
                },
              );
            },
            icon: const Icon(
              IconlyLight.delete,
            ),
          ),
        ],
      ),
      body: LoadingManager(
        isLoading: isLoading,
        child: const CartViewBody(),
      ),
    );
  }

  Future<void> placeOrder({
    required CartProvider cartProvider,
    required ProductProvider productProvider,
    required UserProvider userProvider,
  }) async {
    final auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user == null) {
      return;
    }
    final uid = user.uid;
    try {
      setState(() {
        isLoading = true;
      });
      cartProvider.getCartItems.forEach((key, value) async {
        final getCurrProduct = productProvider.findByProdId(value.productId);
        final orderId = const Uuid().v4();
        await FirebaseFirestore.instance
            .collection("ordersAdvanced")
            .doc(orderId)
            .set({
          'orderId': orderId,
          'userId': uid,
          'productId': value.productId,
          "productTitle": getCurrProduct!.productTitle,
          'price': double.parse(getCurrProduct.productPrice) * value.quantity,
          'totalPrice': cartProvider.getTotal(productProvider: productProvider),
          'quantity': value.quantity,
          'imageUrl': getCurrProduct.productImage,
          'userName': userProvider.getUserModel!.userName,
          'orderDate': Timestamp.now(),
        });
      });
      await cartProvider.clearCartFromFirebase();
      cartProvider.clearLocalCart();
    } catch (e) {
      if (!mounted) return;
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: e.toString(),
        fct: () {},
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
