import 'dart:math';

import 'package:fin_app/products/cart_view_model.dart';
import 'package:fin_app/products/product_model.dart';
import 'package:fin_app/store/application_state.dart';
import 'package:fin_app/store/cart/cart_action.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fluttertoast/fluttertoast.dart';

const dummyProductImages = [
  "camera.jpg",
  "perfume.jpg",
  "dummy.jpg",
  "watch.jpg",
  "placeholder.jpg",
  "watches.jpg"
];

int getRandomImageIndex() {
  return Random().nextInt(dummyProductImages.length - 1);
}

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 200,
      padding: const EdgeInsets.all(2),
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Icon(
                    color: Colors.orange.shade500,
                    Icons.account_balance_wallet_outlined,
                    size: 65,
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  product.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w400),
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "R ${product.price}0 p/m",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 40,
                  child: StoreConnector<ApplicationState, VoidCallback>(
                    converter: (store) {
                      return () => store.dispatch(AddToCartAction(product));
                    },
                    builder: (context, converter) {
                      return Visibility(
                        visible: true,
                        child: OutlinedButton(
                            onPressed: () {
                              converter();
                            },
                            style: OutlinedButton.styleFrom(
                                minimumSize: const Size(100, 40),
                                side: const BorderSide(
                                    width: 3, color: Colors.orange)),
                            child: const Text("Add")),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProductListTile extends StatelessWidget {
  final Product product;

  const ProductListTile(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Colors.grey.shade200,
      leading: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image(
            image: AssetImage(
                'assets/images/carousel/${dummyProductImages[getRandomImageIndex()]}')),
      ),
      title: Text(product.name),
      trailing: Text("R ${product.price.toString()}"),
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProductDetails(product)))
      },
      onLongPress: () {
        Fluttertoast.showToast(
            msg: "Product added",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      },
    );
  }
}

class ProductDetails extends StatelessWidget {
  final Product product;

  const ProductDetails(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(product.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              color: Colors.grey.shade100,
              child: CarouselSlider.builder(
                  itemCount: dummyProductImages.length,
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) =>
                          Image(
                              image: AssetImage(
                            'assets/images/carousel/${dummyProductImages[index]}',
                          )),
                  options: CarouselOptions(
                      viewportFraction: 0.4,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.7)),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}

class CartItemsView extends StatelessWidget {
  const CartItemsView({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<ApplicationState, CartViewModel>(
        builder: (context, viewModel) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
              title:
                  Text("${viewModel.getCartItemsCount()} Items in your cart"),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 8.0),
                      shrinkWrap: true,
                      itemCount: viewModel.getCartItemsCount(),
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blueGrey.shade200,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  color: Colors.orange.shade500,
                                  Icons.account_balance_wallet_outlined,
                                  size: 65,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      RichText(
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        text: TextSpan(
                                            text: viewModel.getCartItemsList()[index].name,
                                            style: TextStyle(
                                                color: Colors.blueGrey.shade800,
                                                fontSize: 16.0)
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      viewModel.removeProductItemFromCart(viewModel.getCartItemsList()[index]);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.orange.shade800,
                                    )),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlinedButton(
                    onPressed: (){
                      viewModel.takeUpProducts();
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(300, 50),
                      side: const BorderSide(
                        width: 3,
                        color: Colors.orange
                      )
                    ),
                    child: const Text("Take Up Items"),
                  ),
                )
              ],
            ),
          );
        },
        converter: (store) => CartViewModel.converter(store));
  }
}
