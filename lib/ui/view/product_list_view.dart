import 'package:challenge/ui/view/product_detail_view.dart';
import 'package:challenge/ui/view_model/product_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../enum/view_model_state.dart';
import '../model/product_model.dart';
import 'package:intl/intl.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  initState() {
    super.initState();
    Future.microtask(() => context.read<ProductListViewModel>().init());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductListViewModel>(
      builder: (context, vm, child) {
        return SafeArea(
            child: Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Theme.of(context).primaryColor,
                  title: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Flutter Challenge 2023')),
                ),
                body: _renderBy(vm)));
      },
    );
  }

  Widget _renderBy(ProductListViewModel vm) {
    if (vm.state == ViewModelState.initial) {
      return const SizedBox.shrink();
    }
    if (vm.state == ViewModelState.loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (vm.state == ViewModelState.error) {
      return const Center(
        child: Text("Error"),
      );
    }
    if (vm.state == ViewModelState.ready) {
      return Column(
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
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: () {
                      if (searchController.text.isEmpty) {
                        vm.reloadList();
                        return;
                      }
                      vm.searchProduct(searchController.text);
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 35,
                    )),
              )
            ],
          ),
          _renderList(vm.products)
        ],
      );
    }
    return SizedBox.shrink();
  }

  Widget _renderList(List<ProductModel> products) {
    if (products.isEmpty) {
      return Expanded(
          child: Center(
        child: Text(searchController.text.isEmpty
            ? "No hay productos"
            : "No se encontró ${searchController.text}"),
      ));
    }
    return Expanded(
      child: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          ProductModel product = products[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        product.title ?? "-",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                              locale: 'en',
                              symbol: "USD",
                              customPattern: 'USD#,##0.00')
                          .format(product.price),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        product.brand ?? "-",
                        style: TextStyle(color: Colors.grey.shade400),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Text(
                          product.description ?? "-",
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
                          builder: ((context) => ProductDetailScreen(
                                productArgs: ProductDetailViewArgs(
                                    productId: product.id,
                                    productName: product.title ?? ""),
                              ))));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
