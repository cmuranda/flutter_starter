import 'package:fin_app/products/product_model.dart';
import 'package:fin_app/store/cart/cart_action.dart';
import 'package:fin_app/store/products/products_action.dart';
import 'package:redux/redux.dart';

import '../store/application_state.dart';

class CartViewModel{
  final Store<ApplicationState> _store;
  final Set<Product> cartProducts;

  bool get hasAnyProducts => cartProducts.isEmpty;

  CartViewModel(
      this._store,
      this.cartProducts
      );

  static CartViewModel converter(
      Store<ApplicationState> store
      ){
    return CartViewModel(
        store,
        store.state.cartState.cartProducts
    );
  }

  void addToCart(Product product){
    _store.dispatch(AddToCartAction(product));
  }

  bool cartContainsProduct(Product product){
    return cartProducts.contains(product);
  }

  int getCartItemsCount() => cartProducts.length;
  List<Product> getCartItemsList() => cartProducts.toList();

  removeProductItemFromCart(product) => _store.dispatch(RemoveFromCartAction(product));

  void takeUpProducts() {
    _store.dispatch(TakeUpProductsAction(cartProducts.toList()));
  }
}