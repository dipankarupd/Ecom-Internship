import 'package:flutter/material.dart';
import 'package:ushopie_ecom/config/themes/theme_constants.dart';
import 'package:ushopie_ecom/features/products/domain/entity/products.dart';
import 'package:ushopie_ecom/features/products/domain/usecases/products_usecase.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/app_bars.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/category_button.dart';
import 'package:ushopie_ecom/features/products/presentation/widges/item_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  final ProductUsecase productUsecase;
  List<Product> groceries = [];
  List<Product> clothes = [];

  HomePage({Key? key, required this.productUsecase}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Product>> productsFuture;

  @override
  void initState() {
    super.initState();

    productsFuture = _fetchData();
  }

  Future<List<Product>> _fetchData() async {
  try {
    List<Product> allProducts = await widget.productUsecase.getAllProducts();

    if (mounted) {
      List<Product> groceries =
          allProducts.where((product) => product.category == "groceries").toList();
      List<Product> clothes =
          allProducts.where((product) => product.category == "clothes").toList();

      setState(() {
        widget.groceries = groceries;
        widget.clothes = clothes;
      });
    }

    return allProducts;
  } catch (error) {
    // Show an alert dialog in case of an error
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred: Reload'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  productsFuture = _fetchData();
                });
              },
              child: const Text('Retry'),
            ),
          ],
        );
      },
    );

    // Rethrow the error to propagate it further
    throw error;
  }
}


  Widget _buildHomePage() {
    List<Widget> _buildCategoryItems(List<Product> items) {
      if (items.isEmpty) {
        return [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 60,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        ];
      }

      return items.take(4).map((item) {
        return ItemWidget(item: item, wishlistItem: false);
      }).toList();
    }

    return Scaffold(
      appBar: const HomePageAppBar(),
      drawer: Drawer(
        child: Container(),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: colorAccent,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search bar and ad ...

                // Category Section ...
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      height: 165,
                      width: 380,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: CarouselSlider(
                        items: [
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://i.ytimg.com/vi/nDHNO6qWPas/maxresdefault.jpg"),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.pexels.com/photos/3352873/pexels-photo-3352873.jpeg?auto=compress&cs=tinysrgb&w=800"),
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.pexels.com/photos/3419791/pexels-photo-3419791.jpeg?auto=compress&cs=tinysrgb&w=800"),
                              ),
                            ),
                          ),
                        ],
                        options: CarouselOptions(
                          autoPlay: true,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          autoPlayInterval: const Duration(seconds: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CategoryButton(items: "Puja Samagri"),
                          CategoryButton(items: "Groceries"),
                          CategoryButton(items: "Clothes"),
                        ],
                      ),
                    ),
                    SizedBox(height: 21),
                  ],
                ),
                // Category 1 (Groceries)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Groceries",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "See all",
                          style: TextStyle(
                            color: colorInfo,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: _buildCategoryItems(widget.groceries),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 17),

                // Category 2 (Clothes)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Clothes",
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "See all",
                          style: TextStyle(
                            color: colorInfo,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        child: Row(
                          children: _buildCategoryItems(widget.clothes),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 25),

                Container(
                  width: 380,
                  height: 180,
                  decoration: const BoxDecoration(
                      image: DecorationImage(image: NetworkImage("https://images.pexels.com/photos/13061761/pexels-photo-13061761.jpeg?auto=compress&cs=tinysrgb&w=800"))
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const SizedBox.shrink(); // Return an empty widget in case of an error
        } else if (snapshot.hasData) {
          return _buildHomePage();
        } else {
          return const SizedBox.shrink(); // Return an empty widget for unknown state
        }
      },
    );
  }
}
