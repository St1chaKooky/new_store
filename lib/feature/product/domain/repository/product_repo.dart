import 'package:new_store/core/domain/repository/result_repo.dart';
import 'package:new_store/feature/product/data/models/product_item_model.dart';
abstract class ProductRepo {
  Future<Result<List<ProductItemModel>>> getProductList(int countProduct, int countSkip);
  Future<Result<ProductItemModel>> getProductItem(String id);  

}