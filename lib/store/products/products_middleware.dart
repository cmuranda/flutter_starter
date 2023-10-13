import 'dart:convert';

import 'package:fin_app/api/api.dart';
import 'package:fin_app/auth/auth_model.dart';
import 'package:fin_app/store/application_state.dart';
import 'package:fin_app/store/auth/auth_middleware.dart';
import 'package:fin_app/store/products/products_action.dart';
import 'package:redux/redux.dart';

class ProductsMiddleware implements MiddlewareClass<ApplicationState>{
  final Api api;

  ProductsMiddleware(this.api);

  @override
  call(Store<ApplicationState> store,
      dynamic action,
      NextDispatcher next
  ) async {
    next(action);

    if (action is LoadProductsAction){
      try{
        final products = await api.getProducts();
        store.dispatch(LoadProductsSucceededAction(products));
      } on ApiException catch (e){
        store.dispatch(LoadProductsFailedAction(e.message));
      }
      return;
    }

    if (action is TakeUpProductsAction){
      checkUserLoggedIn(store);
      var products = action.products;
      List<int> productIds = products.map((product) => product.id).toList();
      AuthUser user = store.state.authState.user!;
      int myCustomerId = user.id;
      String jwt = user.jwtToken;
      await api.takeUpProducts(
          jwt,
          json.encode({
            "customerId": myCustomerId,
            "productIds": productIds
          })
      );
    }

  }

}