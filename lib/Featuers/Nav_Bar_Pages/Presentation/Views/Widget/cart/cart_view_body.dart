import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Core/Widget/empty_widget.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/cart/cart_list_view.dart';
import 'package:store/providers/cart_provider.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? EmptyWidget(
            size: size,
            image: Assets.admin_imagesShoppingCart,
            title: 'Your cart is empty',
            subtitle:
                'Looks like you haven\'t added anything in your cart yet.',
            texButoon: 'Shop Now',
          )
        : const CartListView();
  }
}
