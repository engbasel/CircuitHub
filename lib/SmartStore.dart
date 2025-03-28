// ignore_for_file: file_names

import 'package:store/Featuers/splash/presentation/views/splashview.dart';
import 'package:store/app_router.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/order_provider.dart';
import 'package:store/providers/product_provider.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/providers/user_provider.dart';
import 'package:store/providers/viewed_prod_provider.dart';
import 'package:store/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:store/Core/Utils/theme_data.dart';

import 'package:store/Core/Widget/custom_bottom_nav_bar.dart';

class SmartStore extends StatelessWidget {
  const SmartStore({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ViewedProdProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrdersProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(builder: (
        context,
        themeProvider,
        child,
      ) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          // home: const SplashView(),
          home: const CustomBottomNavBar(),
          onGenerateRoute: AppRouter.generateRoute, // Use onGenerateRoute
          initialRoute: SplashView.routeName,
        );
      }),
    );
  }
}
