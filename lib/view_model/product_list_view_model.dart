import 'package:challenge/model/api/api_response.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import '../model/product_repository.dart';

class ProductListViewModel extends ChangeNotifier {
  ApiResponse _apiResponse = ApiResponse.initial('Empty data');

  ApiResponse get response {
    return _apiResponse;
  }

  final ProductRepository productRepository = ProductRepository();

  List<ProductModel> _products = [];

  List<ProductModel> get products => _products;

  Future<void> getAllProducts() async {
    _apiResponse = ApiResponse.loading('Fetching artist data');
    try {
      var prod = await productRepository.getProductListComplete();
      prod != null ? _products = prod : null;
      _apiResponse = ApiResponse.completed(_products);
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  Future<void> fetchProduct(String value) async {
    _apiResponse = ApiResponse.loading('Fetching artist data');
    try {
      var prod = await productRepository.getProductList(value);
      prod != null ? _products = prod : null;
      _apiResponse = ApiResponse.completed(_products);
    } catch (e) {
      _apiResponse = ApiResponse.error(e.toString());
      print(e);
    }
    
  }

  
}
