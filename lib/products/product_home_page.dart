import 'package:fin_app/products/product_details.dart';
import 'package:fin_app/products/product_model.dart';
import 'package:fin_app/products/product_view_model.dart';
import 'package:fin_app/store/application_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';


class ProductsHomePage extends StatelessWidget {
  const ProductsHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).primaryColor,
            collapsedHeight: 70,
            expandedHeight: 250,
            pinned: true,
            actions: [
              GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CartItemsView())
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Badge(
                    backgroundColor: Colors.white,
                    label: StoreConnector<ApplicationState, String>(
                    converter: (store) => store.state.cartState.cartProducts.length.toString(),
                      builder: (context, itemsCount){
                      return Text(
                        itemsCount,
                        style: const TextStyle(color: Colors.blue),
                      );
                      },
                    ),
                    child: const Icon(Icons.shopping_cart_outlined, size: 30, color: Colors.white,),

                  ),
                ),
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: RadialGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Colors.blue.shade400,
                            Theme.of(context).colorScheme.inversePrimary,
                            Colors.blue.shade50
                          ],
                          radius: 2
                      )
                  )
              ),
              title: const Text("Explore our Products"),
            ),
          ),
          const ProductsListView(),
        ],
      ),
    );
  }
}


class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key});
  @override
  Widget build(BuildContext context) {
    const itemCategories = ["Recommended For You", "Contract", "Insurance", "Investment"];
    return SliverList(
      delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: StoreConnector<ApplicationState, ProductsViewModel>(
                      onInitialBuild: (viewModel) => viewModel.loadProducts(),
                      converter: (store) => ProductsViewModel.converter(store),
                      builder: (context, viewModel) {
                        var categoryName = itemCategories[index];
                        var filteredProducts = viewModel.getFilteredProducts(viewModel.products, categoryName);
                        return ProductCategoryView(categoryName, filteredProducts);
                      }
                    )
                );
              },
        childCount: itemCategories.length
      ),
    );
  }
}

class ProductCategoryView extends StatelessWidget{
  final String categoryType;
  final List<Product> categoryProducts;
  const ProductCategoryView(this.categoryType, this.categoryProducts, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Text(
              categoryType,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            TextButton(
                onPressed: (){},
                child: const Text("More")
            )
          ],
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryProducts.length,
              itemBuilder: (context, index){
                return ProductItem(categoryProducts[index]);
              }),
        )
      ],
    );
  }

}


/*return StoreConnector<ApplicationState, ProductsViewModel>(
        converter: (store) => ProductsViewModel.converter(store),
        onInitialBuild: (viewModel) => viewModel.loadProducts(),
        builder: (context, viewModel) {
          if (viewModel.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Circular progress indicator',
              ),
            );
          }
          else {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Theme.of(context).primaryColor,
                    collapsedHeight: 70,
                    expandedHeight: 250,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Colors.blue.shade400,
                                  Theme.of(context).colorScheme.inversePrimary,
                                  Colors.blue.shade50
                                ],
                              radius: 2
                            )
                          )
                      ),
                      title: const Text("Explore our Products"),
                    ),
                  ),
                  ProductsListView(viewModel.products)
                ],
              ),
            );
          }
        });
  }*/

