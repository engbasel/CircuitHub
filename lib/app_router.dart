import 'package:flutter/material.dart';
import 'package:store/core/widget/custom_bottom_nav_bar.dart';
import 'package:store/featuers/authUseingProvider/forgot_password.dart';
import 'package:store/featuers/authUseingProvider/forgot_password_view.dart';
import 'package:store/featuers/authUseingProvider/login.dart';
import 'package:store/featuers/authUseingProvider/register.dart';
import 'package:store/featuers/chat/presentation/views/chat_bot_view.dart';
import 'package:store/featuers/nav_bar_pages/presentation/views/widget/inner_widget/orders.dart';
import 'package:store/featuers/nav_bar_pages/presentation/views/widget/inner_widget/product_details.dart';
import 'package:store/featuers/nav_bar_pages/presentation/views/widget/inner_widget/viewed_recently.dart';
import 'package:store/featuers/nav_bar_pages/presentation/views/widget/inner_widget/wishlist.dart';
import 'package:store/featuers/nav_bar_pages/presentation/views/widget/search/AIAssistantScreen.dart';
import 'package:store/featuers/nav_bar_pages/presentation/views/widget/search/AI_assestnat_chat.dart';
import 'package:store/featuers/nav_bar_pages/presentation/views/widget/search/search_view.dart';
import 'package:store/featuers/splash/presentation/views/splashview.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ProductDetails.routeName:
        return MaterialPageRoute(builder: (_) => const ProductDetails());
      case Wishlist.routeName:
        return MaterialPageRoute(builder: (_) => const Wishlist());
      case ViewedRecently.routeName:
        return MaterialPageRoute(builder: (_) => const ViewedRecently());
      case Orders.routeName:
        return MaterialPageRoute(builder: (_) => const Orders());
      case ForgotPasswordView.routeName:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordView());
      case SearchView.routeName:
        return MaterialPageRoute(builder: (_) => const SearchView());
      case CustomBottomNavBar.routeName:
        return MaterialPageRoute(builder: (_) => const CustomBottomNavBar());
      case ForgotPasswordScreen.routeName:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case LoginVeiw.routeName:
        return MaterialPageRoute(builder: (_) => const LoginVeiw());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case SplashView.routeName:
        return MaterialPageRoute(builder: (_) => const SplashView());
      case ChatBotView.routeName:
        return MaterialPageRoute(builder: (_) => const ChatBotView());
      case AIAssistant.routeName:
        return MaterialPageRoute(builder: (_) => const AIAssistant());
      case AIAssistantEngginering.routeName:
        return MaterialPageRoute(
            builder: (_) => const AIAssistantEngginering());
      default:
        // Handle unknown routes
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
