import 'package:dio/dio.dart';
import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/feature/product/data/models/product_item_model.dart';
import 'package:new_store/feature/product/data/service/product_api_client.dart';
import 'package:new_store/feature/product/domain/repository/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductApiClient _productApiClient;

  ProductRepoImpl({required ProductApiClient productApiClient})
      : _productApiClient = productApiClient;
  @override
  Future<Result<List<ProductItemModel>>> getProductList(int countProduct, int countSkip) async {
    try {
      final productResponse = await _productApiClient.getAllProductsLimit(countProduct,countSkip);
      final productsList = productResponse.products;
      return DataResult(productsList);
    } on DioException catch (error) {
      
      if (error.response != null){
          return ErrorResult([error.response!.data.toString()]);
        } else {
          return ErrorResult([error.message.toString()]);
        }  
    }
  }
  
  @override
  Future<Result<ProductItemModel>> getProductItem(String id) async {
    try {
      final product = await _productApiClient.getProductItem(id);
      return DataResult(product);
    } on DioException catch (error) {
      if (error.response != null){
          return ErrorResult([error.response!.data.toString()]);
        } else {
          return ErrorResult([error.message.toString()]);
        }  
    }
  }
}
