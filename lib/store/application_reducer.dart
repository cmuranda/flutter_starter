
import 'package:fin_app/store/application_state.dart';
import 'package:fin_app/store/auth/auth_reducer.dart';
import 'package:fin_app/store/cart/cart_reducer.dart';
import 'package:fin_app/store/products/product_reducer.dart';

ApplicationState applicationReducer(ApplicationState state, action){
  return ApplicationState(
    productReducer(state.productsState, action),
    authReducer(state.authState, action),
    cartReducer(state.cartState, action)
  );
}