import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store/Core/Utils/app_styles.dart';

class CategoryDetailsView extends StatelessWidget {
  final String categoryName;

  const CategoryDetailsView({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double horizontalPadding = size.width * 0.04;
    double verticalPadding = size.height * 0.01;
    double crossAxisSpacing = size.width * 0.04;
    double mainAxisSpacing = size.height * 0.02;
    int crossAxisCount = size.width > 600 ? 3 : 2;
    double childAspectRatio = size.width > 600 ? 0.75 : 0.85;

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName,
            style:
                AppStyles.styleMedium16.copyWith(fontSize: size.width * 0.045)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
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
              return Center(
                child: Text(
                  'No products found',
                  style: TextStyle(
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
              );
            }

            var products = snapshot.data!.docs;

            return GridView.builder(
              padding: EdgeInsets.only(top: verticalPadding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: crossAxisSpacing,
                mainAxisSpacing: mainAxisSpacing,
                childAspectRatio: childAspectRatio,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index].data() as Map<String, dynamic>;
                return Card(
                  shadowColor: Colors.white,
                  color: Colors.white, // Set the background color to white
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12)),
                          child: Image.network(
                            product['productImage'],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['productTitle'],
                              style: AppStyles.styleMedium16,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "\$${product['productPrice']}",
                              style: AppStyles.styleBold16
                                  .copyWith(color: Colors.redAccent),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Quantity: ${product['productQuantity']}",
                              style: AppStyles.styleMedium14
                                  .copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
