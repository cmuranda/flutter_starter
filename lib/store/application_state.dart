import 'dart:ui';

import '../products/product_model.dart';
import 'auth/auth_state.dart';
import 'cart/cart_state.dart';

class ApplicationState{
  final DataState<Product> productsState;
  final AuthState authState;
  final CartState cartState;

  ApplicationState(
      this.productsState,
      this.authState,
      this.cartState
  );

  factory ApplicationState.initial(){
    return ApplicationState(
      DataState<Product>.initial(),
      AuthState.initial(),
      CartState.initial()
    );
  }

  ApplicationState copyWith({
    DataState<Product>? productsState,
    AuthState? authState,
    CartState? cartState
  }){
    return ApplicationState(
        productsState ?? this.productsState,
      authState ?? this.authState,
      cartState ?? this.cartState
    );
  }

  @override
  int get hashCode => Object.hash(productsState, authState, cartState);

  @override
  bool operator == (Object other){
    return identical(this, other) ||
        (
            other is ApplicationState &&
            productsState == other.productsState &&
            authState == other.authState &&
            cartState == other.cartState
        );
  }
}

class DataState<T>{
  final Map<int, T> data;
  final String? errorMessage;
  final bool isLoading;

  factory DataState.initial(){
    return DataState(
      {},
      null,
      false
    );
  }

  DataState(
      this.data,
      this.errorMessage,
      this.isLoading
  );

  DataState<T> copyWith({
    Map<int, T>? data,
    String? errorMessage,
    bool? isLoading
  }){
    return DataState<T>(
        data ?? this.data,
        data != null ? null : errorMessage ?? this.errorMessage,
        isLoading ?? this.isLoading
    );
  }

  @override
  int get hashCode => Object.hash(data, errorMessage, isLoading);

  @override
  bool operator == (Object other) {
    return identical(this, other) ||
        (
            other is DataState<T> &&
            data == other.data &&
            errorMessage == other.errorMessage &&
            isLoading == other.isLoading
        );
  }

}