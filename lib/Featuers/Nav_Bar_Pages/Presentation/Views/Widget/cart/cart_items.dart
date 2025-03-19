import 'package:flutter/material.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/cart/product_cart_info.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FittedBox(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              IntrinsicWidth(
                child: ProductCartInfo(size: size),
              )
            ],
          ),
        ),
      ),
    );
  }
}
