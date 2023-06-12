import 'dart:developer';

import 'package:challenge/ui/view_model/product_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../enum/view_model_state.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductDetailViewArgs productArgs;
  const ProductDetailScreen({super.key, required this.productArgs});

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  initState() {
    super.initState();
    Future.microtask(() => context
        .read<ProductDetailViewModel>()
        .init(widget.productArgs.productId));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailViewModel>(
      builder: (context, vm, child) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(widget.productArgs.productName)),
            ),
            body: _renderBy(vm),
          ),
        );
      },
    );
  }

  Widget _renderBy(ProductDetailViewModel vm) {
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          vm.product?.images != null
              ? SizedBox(
                  height: 100,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: vm.product!.images!.map((url) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Image.network(
                          url,
                          fit: BoxFit.contain,
                        ),
                      );
                    }).toList(),
                  ),
                )
              : SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              vm.product?.description ?? "-",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              NumberFormat.currency(locale: 'en', symbol:"USD", customPattern:'USDX.XXX,XX',decimalDigits: 2 ).format(vm.product?.price??0),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    log("no hay funcionalidad");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                  ),
                  child: const Text(
                    "Agregar al carrito",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ),
          const SizedBox(
            height: 60,
          )
        ],
      );
    }
    return SizedBox.shrink();
  }
}

class ProductDetailViewArgs {
  final int productId;
  final String productName;
  ProductDetailViewArgs({required this.productId, required this.productName});
}
