import 'package:challenge/model/product_model.dart';
import 'package:challenge/view/screens/product_detail_screen.dart';
import 'package:challenge/view_model/product_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var prod = Provider.of<ProductListViewModel>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple,
          title: const Align(
              alignment: Alignment.centerLeft,
              child: Text('Flutter Challenge 2023')),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: TextField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Buscar producto',
                        ),
                        onSubmitted: (value) {
                          decide(searchController.text);
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                      onPressed: () {
                        decide(searchController.text);
                      },
                      icon: const Icon(
                        Icons.search,
                        size: 35,
                      )),
                )
              ],
            ),
            FutureBuilder(
                future: decide(searchController.text),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  if (prod.products.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: prod.products.length,
                        itemBuilder: (BuildContext context, int index) {
                          ProductModel product = prod.products[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        product.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                    ),
                                    Text(
                                      "\$ " + product.price.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        product.brand,
                                        style: TextStyle(
                                            color: Colors.grey.shade400),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 30),
                                        child: Text(
                                          product.description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 15),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        "Stock: ${product.stock}",
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              ProductDetailScreen())));
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Center(child: Text("No hay nada"));
                  }
                }),
          ],
        ),
      ),
    );
  }

  Future<void> decide(String value) async {
    if (value.isNotEmpty) {
      await Provider.of<ProductListViewModel>(context, listen: false)
          .fetchProduct(searchController.text);
    } else {
      await Provider.of<ProductListViewModel>(context, listen: false)
          .getAllProducts();
    }
  }
}
