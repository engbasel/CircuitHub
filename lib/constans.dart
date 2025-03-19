import 'package:store/Core/Utils/assets.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Models/categories_model.dart';

const kHorizintalPadding = 12.0;

class AppConstans {
  static const String product1mageUr1 =
      'https://upload.wikimedia.org/wikipedia/commons/9/9c/Choose_an_option.jpg';

  static List<String> bannerslmages = [
    Assets.users_imagesBannersBanner1,
    Assets.users_imagesBannersBanner2
  ];

  static List<CategoriesModel> categoriesListModel = [
    CategoriesModel(
      image: Assets.resistor,
      name: 'Resistors',
      id: Assets.users_imagesCategoriesBookImg,
    ),
    CategoriesModel(
      image: Assets.capacitor,
      name: 'Capacitors',
      id: Assets.users_imagesCategoriesBookImg,
    ),
    CategoriesModel(
      image: Assets.transistors,
      name: 'Transistors',
      id: Assets.users_imagesCategoriesBookImg,
    ),
    CategoriesModel(
      image: Assets.arduino,
      name: 'controllers',
      id: Assets.users_imagesCategoriesBookImg,
    ),
    CategoriesModel(
      image: Assets.sensor,
      name: 'Sensors',
      id: Assets.users_imagesCategoriesBookImg,
    ),
    CategoriesModel(
      image: Assets.diode,
      name: 'Diodes',
      id: Assets.users_imagesCategoriesBookImg,
    ),
    CategoriesModel(
      image: Assets.Curicates,
      name: 'Circuits',
      id: Assets.users_imagesCategoriesBookImg,
    ),
    CategoriesModel(
      image: Assets.connectors,
      name: 'Connector',
      id: Assets.users_imagesCategoriesBookImg,
    ),
  ];
}

class MyValidators {
  static String? displayNamevalidator(String? displayName) {
    if (displayName == null || displayName.isEmpty) {
      return 'Display name cannot be empty';
    }
    if (displayName.length < 3 || displayName.length > 20) {
      return 'Display name must be between 3 and 20 characters';
    }

    return null; // Return null if display name is valid
  }

  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter an email';
    }
    if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
        .hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static String? repeatPasswordValidator({String? value, String? password}) {
    if (value != password) {
      return 'Passwords do not match';
    }
    if (value!.isEmpty) {
      return 'Please confirm your password';
    }
    return null;
  }
}

const kUserData = 'userData';
// const double kHorizintalPadding = 16.0;
const double kTopPaddding = 16.0;
const String kIsOnBoardingViewSeen = 'isOnBoardingViewSeen';
// const String kUserData = 'userData';
