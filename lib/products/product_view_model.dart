import 'package:fin_app/products/product_model.dart';
import 'package:fin_app/store/products/products_action.dart';
import '../store/application_state.dart';
import 'package:redux/redux.dart';

class ProductFilters{
  static List<Product> getDefault(List<Product> products){
    if(products.isEmpty) {
      return [];
    }
    return [products[2], products[5], products[3]];
  }

  static List<Product> getSpecificType(List<Product> products, String type){
    return products.where(
            (product) => product.name.toLowerCase().contains(type.toLowerCase())
    ).toList();
  }

}

class ProductsViewModel{
  final Store<ApplicationState> _store;
  final List<Product> products;
  final bool isLoading;
  final String? errorMessage;

  bool get hasAnyProducts => products.isEmpty;
  bool get hasError => errorMessage != null && products.isEmpty;

  ProductsViewModel(
      this._store,
      this.products,
      this.isLoading,
      this.errorMessage
  );

  static ProductsViewModel converter(
      Store<ApplicationState> store
  ){
    return ProductsViewModel(
        store,
        store.state.productsState.data.values.toList(),
        store.state.productsState.isLoading,
        store.state.productsState.errorMessage
    );
  }

  List<Product> getFilteredProducts(List<Product> products, String filter){
    var filteredProducts = ProductFilters.getSpecificType(products, filter);
    if (filteredProducts.isNotEmpty){
      return filteredProducts;
    }
    return ProductFilters.getDefault(products);
  }

  void loadProducts() => _store.dispatch(LoadProductsAction());
}