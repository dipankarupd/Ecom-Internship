import 'package:flutter/material.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/products/domain/entity/products.dart';
import 'package:ushopie_ecom/features/products/domain/usecases/products_usecase.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/app_bars.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/item_widget.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/search_and_filter.dart';

enum SortOption { all, priceAscending, priceDescending }

enum FilterOption { all, groceries, clothes }
String searchQuery = "";

class CategoryPage extends StatefulWidget {
  final ProductUsecase productUsecase;

  CategoryPage({Key? key, required this.productUsecase}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<Product> products;
  SortOption sortOption = SortOption.all;
  FilterOption filterOption = FilterOption.all;

  @override
  void initState() {
    super.initState();
    products = [];

    widget.productUsecase.getAllProducts().then((result) {
      
        setState(() {
          products = result;
        });
    });
  }

  List<Product> getSortedAndFilteredProducts() {
    List<Product> filteredProducts;

    switch (filterOption) {
      case FilterOption.all:
        filteredProducts = products;
        break;
      case FilterOption.groceries:
        filteredProducts = products.where((product) => product.category == "groceries").toList();
        break;
      case FilterOption.clothes:
        filteredProducts = products.where((product) => product.category == "clothes").toList();
        break;
    }

    switch (sortOption) {
      case SortOption.all:
        break;
      case SortOption.priceAscending:
        filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        break;
      case SortOption.priceDescending:
        filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        break;
    }

    if(searchQuery.isNotEmpty) {
      filteredProducts = filteredProducts.where(
        (elem) => elem.title.toLowerCase()
          .contains(searchQuery.toLowerCase())
      ).toList();
    }

    return filteredProducts;

  }

  @override
  Widget build(BuildContext context) {
    List<Product> sortedAndFilteredProducts = getSortedAndFilteredProducts();

    return Scaffold(
      appBar: const ApplicationToolBar(title: "Groceries"),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        color: colorAccent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search and Filter:
            SearchAndFilter(
              onSortOptionChanged: (option) {
                setState(() {
                  sortOption = option;
                });
              },
              onFilterOptionChanged: (option) {
                setState(() {
                  filterOption = option;
                });
              },
              onSearchQueryChanged: (query) {
                setState(() {
                  searchQuery = query;
                });
              }
            ),

            // All items
            Expanded(
              child: sortedAndFilteredProducts.isEmpty
                  ? const Center(
                      child: const CircularProgressIndicator(),
                    )
                  : GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.88,
                      ),
                      itemBuilder: (context, index) {
                        if (index >= sortedAndFilteredProducts.length) return null;
                        return ItemWidget(item: sortedAndFilteredProducts[index], wishlistItem: false);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
