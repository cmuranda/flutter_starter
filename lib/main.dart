import 'package:fin_app/api/api.dart';
import 'package:fin_app/auth/sign_in.dart';
import 'package:fin_app/kyc/kyc_document.dart';
import 'package:fin_app/products/product_details.dart';
import 'package:fin_app/products/product_home_page.dart';
import 'package:fin_app/store/application_reducer.dart';
import 'package:fin_app/store/application_state.dart';
import 'package:fin_app/store/auth/auth_middleware.dart';
import 'package:fin_app/store/products/products_middleware.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';

import 'home_page.dart';
import 'kyc/kyc_identity_card.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final api = Api();

  App({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var store = Store<ApplicationState>(
        applicationReducer,
        initialState: ApplicationState.initial(),
        middleware: [
          const NavigationMiddleware<ApplicationState>(),
          ProductsMiddleware(api),
          AuthMiddleware(api)
        ]
    );

    MaterialPageRoute buildRoute(RouteSettings settings, Widget builder) {
      return MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => builder,
      );
    }

    Route getRoute(RouteSettings settings){
      switch (settings.name){
        case "/products-home":
          return buildRoute(settings, const ProductsHomePage());
        case "/sign-in":
          return buildRoute(settings, const SignInPage());
        case "/cart":
          return buildRoute(settings, const CartItemsView());
        case "/kyc-identity":
          return buildRoute(settings, KYCIdentityCard());

        default:
          // return buildRoute(settings, const HomePage(title: 'Finance App'));
          return buildRoute(settings, KYCIdentityCard());

      }
    }

    return StoreProvider<ApplicationState>(
      store: store,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Finance Application',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue.shade900,
            brightness: Brightness.light,
            primary: Colors.blue.shade800,
              secondary: Colors.orange.shade800
          ),
          fontFamily: 'Urbanite',
          appBarTheme: const AppBarTheme(
            foregroundColor: Colors.white
          ),
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        // home: const HomePage(title: 'Finance App'),
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: getRoute,
      ),
    );
  }
}




