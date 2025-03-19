import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/cart/cart_items.dart';
import 'package:store/providers/cart_provider.dart';

class CartListView extends StatelessWidget {
  const CartListView({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cartProvider.getCartItems.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: cartProvider.getCartItems.values
                    .toList()
                    .reversed
                    .toList()[index],
                child: const CartItems(),
              );
            },
          ),
        ),
        const SizedBox(
          height: kBottomNavigationBarHeight + 10,
        )
      ],
    );
  }
}
