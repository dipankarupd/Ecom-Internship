
import 'package:ushopie_ecom/features/cart/domain/entity/cart_product.dart';

class CartProductModel extends CartProductEntity {
  


  CartProductModel({
    required super.id,
    required super.title,
    required super.category,
    required super.thumbNail,
    required super.price,
    required super.amount,
    required super.productId,
  });

  CartProductModel.fromJson(Map<String, dynamic> json) 
    : super(
      id: json['id'],
      title: json['title'],
      category: json['category'],
      thumbNail: json['thumbNail'],
      price: json['price'],
      amount: json['amount'],
      productId: json['productId']
    );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['category'] = category;
    _data['thumbNail'] = thumbNail;
    _data['price'] = price;
    _data['amount'] = amount;
    _data['productId'] = productId;
    return _data;
  }

}