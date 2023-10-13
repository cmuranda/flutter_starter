import 'package:fin_app/store/application_state.dart';
import 'package:fin_app/store/products/products_action.dart';
import 'package:redux/redux.dart';
import 'package:fin_app/products/product_model.dart';

final productReducer = combineReducers<DataState<Product>>([
  TypedReducer<DataState<Product>, LoadProductsAction>(onProductsLoading),
  TypedReducer<DataState<Product>, LoadProductsSucceededAction>(onProductsLoaded),
  TypedReducer<DataState<Product>, LoadProductsFailedAction>(onProductsLoadFailure)
]);

DataState<Product> onProductsLoading(
  DataState<Product> state,
  action
){
  return state.copyWith(isLoading: true);
}

DataState<Product> onProductsLoaded(
  DataState<Product> state,
  LoadProductsSucceededAction action
){
  final products = Map<int, Product>.from(state.data);

  for (final product in action.products){
    products[product.id] = product;
  }

  return state.copyWith(
    isLoading: false,
    data: products
  );
}

DataState<Product> onProductsLoadFailure(
  DataState<Product> state,
  LoadProductsFailedAction action
){
  return state.copyWith(
    isLoading: false,
    errorMessage: action.error
  );
}