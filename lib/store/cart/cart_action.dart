import 'package:fin_app/products/product_model.dart';

abstract class CartAction{}

class AddToCartAction extends CartAction{
  final Product product;
  AddToCartAction(this.product);

  @override
  String toString() => "$AddToCartAction";
}

class RemoveFromCartAction extends CartAction{
  final Product product;
  RemoveFromCartAction(this.product);

  @override
  String toString() => "$RemoveFromCartAction";
}