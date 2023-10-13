import 'package:fin_app/products/product_model.dart';
import 'package:flutter/foundation.dart';

class CartState{
  final Set<Product> cartProducts;

  const CartState(this.cartProducts);

  factory CartState.initial(){
    return const CartState({});
  }



  @override
  int get hashCode => Object.hash(cartProducts, null);

  @override
  bool operator == (Object other) {
    return identical(this, other) ||
        (
            other is CartState &&
            setEquals(cartProducts, other.cartProducts)
        );
  }

}