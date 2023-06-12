import 'package:challenge/ui/model/product_model.dart';
import 'package:flutter/material.dart';

import '../../enum/view_model_state.dart';
import '../../model/product_repository.dart';

class ProductListViewModel extends ChangeNotifier {

  final ProductRepository productRepository = ProductRepository();

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  ViewModelState _state = ViewModelState.initial;
  ViewModelState get state => _state;

  init() async {
    _state = ViewModelState.loading;
    notifyListeners();
    try {
      //initFunction
      await _getAllProducts();
      _state = ViewModelState.ready;
    } catch (e) {
      _state = ViewModelState.error;
      print('Error fetching products: $e');
    }
    notifyListeners();
  }

  reloadList() async {
    _state = ViewModelState.loading;
    notifyListeners();
    try {
      //initFunction
      await _getAllProducts();
      _state = ViewModelState.ready;
    } catch (e) {
      _state = ViewModelState.error;
      print('Error fetching products: $e');
    }
    notifyListeners();
  }

  searchProduct(String value) async {
    if (value.isEmpty) {
      return;
    }
    _state = ViewModelState.loading;
    notifyListeners();
    try {
      //initFunction
      await _fetchProduct(value);
      _state = ViewModelState.ready;
    } catch (e) {
      _state = ViewModelState.error;
      print('Error fetching products: $e');
    }
    notifyListeners();
  }

  Future<void> _getAllProducts() async {
    var prod = await productRepository.getProductListComplete();
    prod != null ? _products = prod : null;
  }

  Future<void> _fetchProduct(String value) async {
    var prod = await productRepository.getProductList(value);
    prod != null ? _products = prod : null;
  }
}


