import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Models/cart_model.dart';

import 'package:store/providers/cart_provider.dart';

class QuantityBottomSheet extends StatelessWidget {
  const QuantityBottomSheet({super.key, required this.cartModel});
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 50,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  cartProvider.updataQuantity(
                    productId: cartModel.productId,
                    quantity: index + 1,
                  );
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: AppStyles.styleMedium20,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
