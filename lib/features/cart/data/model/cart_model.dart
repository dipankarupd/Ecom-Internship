
import 'package:ushopie_ecom/features/cart/data/model/cart_product_model.dart';
import 'package:ushopie_ecom/features/cart/domain/entity/cart.dart';

class CartModel extends Cart {

  CartModel({
    required List<CartProductModel> products
  }) : super(
    products: products
  );

  CartModel.fromJson(Map<String, dynamic> json) : super(
     products: (json['product'] as List<dynamic>)
      .map((productJson) => CartProductModel.fromJson(productJson))
      .toList(),
  );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['products'] = products.map((e)=>e.toJson()).toList();
    return _data;
  }
}