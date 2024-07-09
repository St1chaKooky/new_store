import 'package:dio/dio.dart';
import 'package:new_store/feature/product/data/models/product_item_model.dart';
import 'package:new_store/feature/product/data/models/product_model.dart';
import 'package:retrofit/retrofit.dart';
part 'product_api_client.g.dart';

@RestApi(baseUrl: 'https://dummyjson.com/')
abstract class ProductApiClient {
  factory ProductApiClient(Dio dio, {String baseUrl}) = _ProductApiClient;
  @GET('/products/{id}')
  Future<ProductItemModel> getProductItem(@Path('id') String id);

  @GET('products')
  Future<ProductModel> getAllProductsLimit(
    @Query('limit') int count,
    @Query('skip') int skip,
  );
}