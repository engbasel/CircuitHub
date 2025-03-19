import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Models/order.dart';

class OrdersWidgetItems extends StatefulWidget {
  const OrdersWidgetItems({super.key, required this.ordersModelAdvanced});
  final OrdersModelAdvanced ordersModelAdvanced;

  @override
  State<OrdersWidgetItems> createState() => _OrdersWidgetItemsState();
}

class _OrdersWidgetItemsState extends State<OrdersWidgetItems> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FancyShimmerImage(
              height: size.width * 0.25,
              width: size.width * 0.25,
              imageUrl: widget.ordersModelAdvanced.imageUrl,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.ordersModelAdvanced.productTitle,
                          maxLines: 2,
                          style: AppStyles.styleMedium14,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 22,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      const Text(
                        'Price:  ',
                        style: AppStyles.styleMedium14,
                      ),
                      Flexible(
                        child: Text(
                          "${widget.ordersModelAdvanced.price} \$",
                          style: AppStyles.styleMedium14.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Qty: ${widget.ordersModelAdvanced.quantity}",
                    style: AppStyles.styleMedium14,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
