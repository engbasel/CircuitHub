import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Widget/product_widget.dart';

class CategoryDetailsView extends StatelessWidget {
  final String categoryName;

  const CategoryDetailsView({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName, style: AppStyles.styleMedium16),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('electrionuics_product')
              .where('productCategory', isEqualTo: categoryName)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text('No products found',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)));
            }

            var products = snapshot.data!.docs;

            return GridView.builder(
              padding: const EdgeInsets.only(top: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductWidget(productId: products[index].id);
              },
            );
          },
        ),
      ),
    );
  }
}
