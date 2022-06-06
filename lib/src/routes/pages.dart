import 'package:delivery_food/src/routes/routes.dart';
import 'package:delivery_food/src/ui/global_widgets/is_auth.dart';
import 'package:delivery_food/src/ui/pages/bienvenida/welcome_page.dart';
import 'package:delivery_food/src/ui/pages/carrito/carrito_page.dart';
import 'package:delivery_food/src/ui/pages/forgot_password/forgot_password_page.dart';
import 'package:delivery_food/src/ui/pages/home/home_page.dart';
import 'package:delivery_food/src/ui/pages/login/login_page.dart';
import 'package:delivery_food/src/ui/pages/onboard/onboard_page.dart';
import 'package:delivery_food/src/ui/pages/plato/dish_detail_page.dart';
import 'package:delivery_food/src/ui/pages/register/register_page.dart';
import 'package:delivery_food/src/ui/pages/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';

abstract class Pages {
  static const String initial = Routes.Splash; //Routes.Onboard;
  static final Map<String, Widget Function(BuildContext)> routes = {
    Routes.Onboard: (context) => const OnboardPage(),
    Routes.Welcome: (context) => const WelcomePage(),
    Routes.Login: (context) => const LoginPage(),
    Routes.Register: (context) => const RegisterPage(),
    Routes.Forgot: (context) => const ForgotPasswordPage(),
    Routes.Home: (context) => const IsAuth(
        page:
            HomePage()), //le ponemos nuuestro isAuth, seria como nuestro tipo guard para q acceda si es que esta autenticado, mas para web
    Routes.Dish: (context) => const IsAuth(page: DishDetailPage()),
    Routes.Carrito: (context) => const IsAuth(page: CarritoPage()),
    Routes.Splash: (context) => const SplashPage(),
  };
}
