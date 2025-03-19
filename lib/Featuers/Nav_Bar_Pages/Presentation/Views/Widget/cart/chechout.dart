import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/cart/bouttom_checkout.dart';
import 'package:store/providers/cart_provider.dart';

class Checkout extends StatelessWidget {
  const Checkout({
    super.key,
    required this.function,
  });

  final Function function;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? const SizedBox.shrink()
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border(
                  top: BorderSide(
                      color: Theme.of(context).dividerColor, width: 1)),
            ),
            child: SizedBox(
              height: kBottomNavigationBarHeight + 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: BouttomCheckout(
                  function: function,
                ),
              ),
            ),
          );
  }
}
