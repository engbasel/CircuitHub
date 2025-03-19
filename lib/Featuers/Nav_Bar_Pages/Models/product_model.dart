import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String productId,
      productTitle,
      productPrice,
      productCategory,
      productImage,
      productDescription,
      productQuantity;
  Timestamp? createdAt;
  ProductModel(
      {required this.productId,
      this.createdAt,
      required this.productTitle,
      required this.productPrice,
      required this.productCategory,
      required this.productImage,
      required this.productDescription,
      required this.productQuantity});

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return ProductModel(
        productId: data['productId'],
        createdAt: data['createdAt'],
        productTitle: data['productTitle'],
        productPrice: data['productPrice'],
        productCategory: data['productCategory'],
        productImage: data['productImage'],
        productDescription: data['productDescription'],
        productQuantity: data['productQuantity']);
  }
}
