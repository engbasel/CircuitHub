// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:store/Core/Utils/app_styles.dart';
// import 'package:store/providers/cart_provider.dart';
// import 'package:store/providers/product_provider.dart';

// class CheckoutScreen extends StatefulWidget {
//   const CheckoutScreen({super.key});
//   static const routeName = 'CheckoutScreen';

//   @override
//   State<CheckoutScreen> createState() => _CheckoutScreenState();
// }

// class _CheckoutScreenState extends State<CheckoutScreen> {
//   String selectedPaymentMethod = 'Credit Card';
//   final TextEditingController addressController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductProvider>(context);
//     final cartProvider = Provider.of<CartProvider>(context);
//     double totalAmount = 299.99; // تقدر تجيبها من provider أو تحسبها

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Checkout'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Order Summary',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Total (${cartProvider.getCartItems.length} product /${cartProvider.getQty()} items) ',
//                   style: AppStyles.styleMedium16,
//                 ),
//                 Text(
//                   '${cartProvider.totalAmount(productProvider: productProvider)}\$',
//                   style: AppStyles.styleMedium16,
//                 ),
//               ],
//             ),
//             const Divider(height: 32),
//             const Text(
//               'Shipping Address',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             TextField(
//               controller: addressController,
//               decoration: const InputDecoration(
//                 hintText: 'Enter your address',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 16),
//             const Text(
//               'Payment Method',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             ListTile(
//               title: const Text('Credit Card'),
//               leading: Radio<String>(
//                 value: 'Credit Card',
//                 groupValue: selectedPaymentMethod,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedPaymentMethod = value!;
//                   });
//                 },
//               ),
//             ),
//             ListTile(
//               title: const Text('Cash on Delivery'),
//               leading: Radio<String>(
//                 value: 'Cash on Delivery',
//                 groupValue: selectedPaymentMethod,
//                 onChanged: (value) {
//                   setState(() {
//                     selectedPaymentMethod = value!;
//                   });
//                 },
//               ),
//             ),
//             const Spacer(),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (addressController.text.isEmpty) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                           content: Text('Please enter your address')),
//                     );
//                     return;
//                   }

//                   // simulate payment
//                   showDialog(
//                     context: context,
//                     builder: (_) => AlertDialog(
//                       title: const Text('Payment Successful'),
//                       content: Text(
//                           'You paid \$$totalAmount using $selectedPaymentMethod'),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context); // close dialog
//                             Navigator.pop(context); // go back
//                           },
//                           child: const Text('OK'),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//                 child: const Text('Pay Now'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/product_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});
  static const routeName = 'CheckoutScreen';

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String selectedPaymentMethod = 'Credit Card';
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expiryDateController = TextEditingController();
  final TextEditingController cvvController = TextEditingController();
  final TextEditingController cardHolderNameController =
      TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    num totalAmount =
        cartProvider.totalAmount(productProvider: productProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Summary',
              style:
                  AppStyles.styleMedium16.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    'Total (${cartProvider.getCartItems.length} product / ${cartProvider.getQty()} items)'),
                Text('${totalAmount.toStringAsFixed(2)}\$'),
              ],
            ),
            const Divider(height: 32),
            Text(
              'Shipping Address',
              style:
                  AppStyles.styleMedium16.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: addressController,
              decoration: const InputDecoration(
                hintText: 'Enter your address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Payment Method',
              style:
                  AppStyles.styleMedium16.copyWith(fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: const Text('Credit Card'),
              leading: Radio<String>(
                value: 'Credit Card',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Cash on Delivery'),
              leading: Radio<String>(
                value: 'Cash on Delivery',
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value!;
                  });
                },
              ),
            ),
            if (selectedPaymentMethod == 'Credit Card') ...[
              const SizedBox(height: 16),
              _buildCreditCardPreview(),
              const SizedBox(height: 16),
              _buildCreditCardForm(),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _handlePayment,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _handlePayment,
                            child: const Text(
                              'Pay Now',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditCardPreview() {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Colors.deepPurple, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Credit Card', style: TextStyle(color: Colors.white)),
          const Spacer(),
          Text(
            cardNumberController.text.isEmpty
                ? '**** **** **** ****'
                : cardNumberController.text,
            style: const TextStyle(
                color: Colors.white, fontSize: 20, letterSpacing: 2),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardHolderNameController.text.isEmpty
                    ? 'Card Holder'
                    : cardHolderNameController.text,
                style: const TextStyle(color: Colors.white),
              ),
              Text(
                expiryDateController.text.isEmpty
                    ? 'MM/YY'
                    : expiryDateController.text,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreditCardForm() {
    return Column(
      children: [
        TextField(
          controller: cardNumberController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Card Number',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: expiryDateController,
                keyboardType: TextInputType.datetime,
                decoration: const InputDecoration(
                  labelText: 'Expiry Date',
                  hintText: 'MM/YY',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: cvvController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'CVV',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        TextField(
          controller: cardHolderNameController,
          decoration: const InputDecoration(
            labelText: 'Card Holder Name',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  void _handlePayment() async {
    if (addressController.text.isEmpty) {
      _showSnackBar('Please enter your address');
      return;
    }

    if (selectedPaymentMethod == 'Credit Card') {
      if (cardNumberController.text.isEmpty ||
          expiryDateController.text.isEmpty ||
          cvvController.text.isEmpty ||
          cardHolderNameController.text.isEmpty) {
        _showSnackBar('Please fill in all credit card details');
        return;
      }
    }

    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2)); // simulate fake loading

    setState(() {
      isLoading = false;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const OrderConfirmedScreen()),
    );
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }
}

class OrderConfirmedScreen extends StatelessWidget {
  const OrderConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, size: 100, color: Colors.green),
              const SizedBox(height: 24),
              const Text(
                'Your order has been placed successfully!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your order will be delivered shortly.\nThank you for shopping with us ❤️',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: const Text('العودة للرئيسية'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
