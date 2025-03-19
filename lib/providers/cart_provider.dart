import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:store/Core/Utils/my_app_method.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Models/cart_model.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Models/product_model.dart';

import 'package:store/providers/product_provider.dart';
import 'package:uuid/uuid.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> cartItems = {};

  Map<String, CartModel> get getCartItems {
    return cartItems;
  }

  bool isProductInCart({
    required String productId,
  }) {
    return cartItems.containsKey(productId);
  }

  final usersDB = FirebaseFirestore.instance.collection("users");
  final _auth = FirebaseAuth.instance;
  Future<void> addToCartFirebase(
      {required String productId,
      required int qty,
      required BuildContext context}) async {
    final User? user = _auth.currentUser;
    if (user == null) {
      MyAppMethods.showErrorORWarningDialog(
          context: context, subtitle: "No user found", fct: () {});
      return;
    }
    final uid = user.uid;
    final cartId = const Uuid().v4();
    try {
      usersDB.doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            "cartId": cartId,
            'productId': productId,
            'quantity': qty,
          }
        ])
      });
      await fetchCart();
      Fluttertoast.showToast(msg: "Item has been added to cart");
    } catch (e) {
      rethrow;
    }
  }

  Future<void> fetchCart() async {
    User? user = _auth.currentUser;
    if (user == null) {
      log("the function has been called and the user is null");
      cartItems.clear();
      return;
    }
    try {
      final userDoc = await usersDB.doc(user.uid).get();
      final data = userDoc.data();
      if (data == null || !data.containsKey("userCart")) {
        return;
      }
      final leng = userDoc.get("userCart").length;
      for (int index = 0; index < leng; index++) {
        cartItems.putIfAbsent(
          userDoc.get('userCart')[index]['productId'],
          () => CartModel(
            cartId: userDoc.get('userCart')[index]['cartId'],
            productId: userDoc.get('userCart')[index]['productId'],
            quantity: userDoc.get('userCart')[index]['quantity'],
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> removeCartItemFromFirebase(
      {required String cartId,
      required String productId,
      required int qty}) async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({
        "userCart": FieldValue.arrayRemove([
          {
            "cartId": cartId,
            'productId': productId,
            'quantity': qty,
          }
        ])
      });
      cartItems.remove(productId);
      await fetchCart();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  Future<void> clearCartFromFirebase() async {
    User? user = _auth.currentUser;
    try {
      await usersDB.doc(user!.uid).update({"userCart": []});
      cartItems.clear();
    } catch (e) {
      rethrow;
    }
    notifyListeners();
  }

  void addItemsToCart({
    required String productId,
  }) {
    cartItems.putIfAbsent(
      productId,
      () => CartModel(
        productId: productId,
        quantity: 1,
        cartId: const Uuid().v4(),
      ),
    );

    notifyListeners();
  }

  void updataQuantity({
    required String productId,
    required int quantity,
  }) {
    cartItems.update(
      productId,
      (item) => CartModel(
        productId: productId,
        quantity: quantity,
        cartId: item.cartId,
      ),
    );

    notifyListeners();
  }

  num totalAmount({required ProductProvider productProvider}) {
    num total = 0.0;
    cartItems.forEach(
      (key, value) {
        final ProductModel? getCurrProduct = productProvider.findByProdId(
          value.productId,
        );
        if (getCurrProduct == null) {
          total += 0;
        } else {
          total += num.parse(getCurrProduct.productPrice) * value.quantity;
        }
      },
    );
    return total;
  }

  void removeOneItem({
    required String productId,
  }) {
    cartItems.remove(
      productId,
    );

    notifyListeners();
  }

  void clearLocalCart() {
    cartItems.clear();

    notifyListeners();
  }

  int getQty() {
    int total = 0;
    cartItems.forEach(
      (key, value) {
        total += value.quantity;
      },
    );
    return total;
  }

  double getTotal({required ProductProvider productProvider}) {
    double total = 0.0;
    cartItems.forEach((key, value) {
      final ProductModel? getCurrProduct =
          productProvider.findByProdId(value.productId);
      if (getCurrProduct == null) {
        total += 0;
      } else {
        total += double.parse(getCurrProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }
}
