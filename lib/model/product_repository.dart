import 'package:challenge/model/services/base_service.dart';
import 'package:challenge/model/services/media_service.dart';
import 'package:challenge/ui/model/product_model.dart';

class ProductRepository {
  BaseService _productService = Service();

  Future<List<ProductModel>?> getProductListComplete() async {
    dynamic response = await _productService.getResponse("products");
    final jsonData = response['products'] as List;

    List<ProductModel>? productList =
        jsonData.map((tagJson) => ProductModel.fromJson(tagJson)).toList();

    return productList;
  }

  Future<List<ProductModel>?> getProductList(String value) async {
    dynamic response =
        await _productService.getResponse("products/search?q=$value");
    final jsonData = response['products'] as List;

    List<ProductModel>? productList =
        jsonData.map((tagJson) => ProductModel.fromJson(tagJson)).toList();

    return productList;
  }

  Future<ProductModel?> getProductDetail(int value) async {
    dynamic response = await _productService.getResponse("products/$value");
    ProductModel? productDetail = ProductModel.fromJson(response);

    return productDetail;
  }
}
