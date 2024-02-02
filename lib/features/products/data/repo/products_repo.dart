
import 'package:ushopie_ecom/features/products/data/source/remote.dart';
import 'package:ushopie_ecom/features/products/domain/entity/products.dart';
import 'package:ushopie_ecom/features/products/domain/repo/products_repo.dart';

class ProductsRepoImpl implements ProductsRepo {

  final RemoteSourceProduct remoteProduct;

  ProductsRepoImpl({required this.remoteProduct});

  @override
  Future<List<Product>> getProducts() {
    try {
      return remoteProduct.getItems();
    } catch (e){
      throw Exception(e);
    }
  }
  
  @override
  Future<List<Product>> getProductsByCategory(String category) {
    
    try {
      return remoteProduct.getItemByCategory(category);
    } catch(e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<Product> getIndividualProduct(int id) {
    try {
      return remoteProduct.getIndividualItem(id);
    } catch(e) {
      throw Exception(e);
    }
  }

  
}