import 'package:flutter/material.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Models/viewed_prod_model.dart';
import 'package:uuid/uuid.dart';

class ViewedProdProvider with ChangeNotifier {
  final Map<String, ViewedProdModel> viewedProdItems = {};

  Map<String, ViewedProdModel> get getviewedProdItems {
    return viewedProdItems;
  }

  // bool isProductInViewedProd({
  //   required String productId,
  // }) {
  //   return viewedProdItems.containsKey(productId);
  // }

  void addProductToHistory({
    required String productId,
  }) {
    viewedProdItems.putIfAbsent(
      productId,
      () => ViewedProdModel(
        productId: productId,
        id: const Uuid().v4(),
      ),
    );

    notifyListeners();
  }

  void clearLocalViewedProd() {
    viewedProdItems.clear();

    notifyListeners();
  }
}
