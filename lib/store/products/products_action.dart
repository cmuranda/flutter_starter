import '../../products/product_model.dart';

abstract class ProductsAction{}

class LoadProductsAction implements ProductsAction{
  @override
  String toString() => "$LoadProductsAction";
}

class LoadProductsSucceededAction implements ProductsAction{
  final List<Product> products;

  LoadProductsSucceededAction(this.products);

  @override
  String toString() => "$LoadProductsSucceededAction";
}

class LoadProductsFailedAction implements ProductsAction {
  final String error;

  LoadProductsFailedAction(this.error);

  @override
  String toString() => "$LoadProductsFailedAction($error)";
}

class TakeUpProductsAction implements ProductsAction{
  final List<Product> products;

  TakeUpProductsAction(this.products);

  @override
  String toString() => "$TakeUpProductsAction";
}