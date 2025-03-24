import 'dart:ui';

class CategoriesModel {
  final String name;
  final String image;
  Color colorLight;
  Color colorDark;

  final String id;

  CategoriesModel({
    required this.id,
    required this.colorLight,
    required this.colorDark,
    required this.image,
    required this.name,
  });
}
