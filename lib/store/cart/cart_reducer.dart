
import 'package:fin_app/products/product_model.dart';
import 'package:fin_app/store/cart/cart_action.dart';
import 'package:fin_app/store/cart/cart_state.dart';
import 'package:redux/redux.dart';

final cartReducer = combineReducers<CartState>([
  TypedReducer<CartState, AddToCartAction>(onAddToCart),
  TypedReducer<CartState, RemoveFromCartAction>(onRemoveFromCart)
]);

CartState onAddToCart(
    CartState state,
    action
){
  var stateProducts = Set<Product>.from(state.cartProducts);
  stateProducts.add(action.product);
  return CartState(stateProducts);
}

CartState onRemoveFromCart(
    CartState state,
    action
    ){
  var stateProducts = Set<Product>.from(state.cartProducts);
  stateProducts.remove(action.product);
  return CartState(stateProducts);
}