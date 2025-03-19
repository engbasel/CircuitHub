import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/app_name_animated_text.dart';
import 'package:store/Core/Utils/assets.dart';
import 'package:store/Core/Widget/empty_widget.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/orders_widget_items.dart';
import 'package:store/providers/order_provider.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});
  static const routeName = 'Orders';

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  bool isEmptyOrders = false;
  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const AppNameAnimatedText(
          text: 'Place Order',
          fontSize: 20,
        ),
      ),
      body: FutureBuilder(
        future: ordersProvider.fetchOrder(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child:
                  Center(child: Text('Something went wrong ${snapshot.error}')),
            );
          } else if (snapshot.data == null) {
            return EmptyWidget(
              size: MediaQuery.of(context).size,
              image: Assets.users_imagesBagBagWish,
              title: 'Your Orders is empty',
              subtitle:
                  'Looks like you haven\'t added anything in your Orders yet.',
              texButoon: 'Shop Now',
            );
          }
          return ListView.separated(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return OrdersWidgetItems(
                ordersModelAdvanced: snapshot.data![index],
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        },
      ),
    );
  }
}
