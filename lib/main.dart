import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Services/custom_block_observer.dart';
import 'package:store/Core/Services/shared_preferences_sengleton.dart';
import 'package:store/Core/Utils/theme_data.dart';
import 'package:store/Core/Widget/nav_bar.dart';
import 'package:store/Featuers/Chat/presentation/views/chat_bot_view.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/orders.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/product_details.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/viewed_recently.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/inner_widget/wishlist.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/search/search_view.dart';
import 'package:store/Featuers/authUseingProvider/forgot_password.dart';
import 'package:store/Featuers/authUseingProvider/forgot_password_view.dart';
import 'package:store/Featuers/authUseingProvider/login.dart';
import 'package:store/Featuers/authUseingProvider/register.dart';
import 'package:store/Featuers/splash/presentation/views/splashview.dart';
import 'package:store/firebase_options.dart';
import 'package:store/providers/cart_provider.dart';
import 'package:store/providers/order_provider.dart';
import 'package:store/providers/product_provider.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/providers/user_provider.dart';
import 'package:store/providers/viewed_prod_provider.dart';
import 'package:store/providers/wishlist_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = CustomBlockObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Prefs.init();
  // setupGetit();
  runApp(const SmartStore());
}

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
          home: const SplashView(),
          routes: {
            ProductDetails.routeName: (context) => const ProductDetails(),
            Wishlist.routeName: (context) => const Wishlist(),
            ViewedRecently.routeName: (context) => const ViewedRecently(),
            Orders.routeName: (context) => const Orders(),
            ForgotPasswordView.routeName: (context) =>
                const ForgotPasswordView(),
            SearchView.routeName: (context) => const SearchView(),
            NavBar.routeName: (context) => const NavBar(),
            ForgotPasswordScreen.routeName: (context) =>
                const ForgotPasswordScreen(),
            LoginVeiw.routeName: (context) => const LoginVeiw(),
            RegisterScreen.routeName: (context) => const RegisterScreen(),
            SplashView.routeName: (context) => const SplashView(),
            'ChatBotViewBody': (context) => const ChatBotView(),
          },
        );
      }),
    );
  }
}
