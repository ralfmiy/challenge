import 'package:challenge/ui/model/product_model.dart';
import 'package:flutter/cupertino.dart';

import '../../enum/view_model_state.dart';

import '../../model/product_repository.dart';

class ProductDetailViewModel with ChangeNotifier {
  final ProductRepository productRepository = ProductRepository();

  ProductModel? _product;

  ProductModel? get product => _product;

  ViewModelState _state = ViewModelState.initial;
  ViewModelState get state => _state;

  init(int value) async {
    _state = ViewModelState.loading;
    notifyListeners();
    try {
      //initFunction
      await _getDetail(value);
      _state = ViewModelState.ready;
    } catch (e) {
      _state = ViewModelState.error;
      print('Error fetching products: $e');
    }
    notifyListeners();
  }

  Future<void> _getDetail(int value) async {
    var prod = await productRepository.getProductDetail(value);
    prod != null ? _product = prod : null;
  }
}
