import 'package:ushopie_ecom/features/products/data/models/products_model.dart';

class WishlistItems {
  WishlistItems({
    
    required this.product,
  });
  
  late final List<ProductModel> product;
  
  WishlistItems.fromJson(Map<String, dynamic> json){
    
    product = List.from(json['product']).map((e)=>ProductModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    
    _data['product'] = product.map((e)=>e.toJson()).toList();
    return _data;
  }
}
