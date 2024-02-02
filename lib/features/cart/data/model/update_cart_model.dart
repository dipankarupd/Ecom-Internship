
import 'package:ushopie_ecom/features/cart/domain/entity/update_cart.dart';

class UpdateCartModel extends UpdateCart {

  UpdateCartModel ({
    required String amount,
    required int userId,
    required String productId
  }) : super(
    amount: amount,
    userId: userId,
    productId: productId
  );


  UpdateCartModel.fromJson(Map<String, dynamic> json) : super(
    amount: json['amount'],
    userId: json['userId'],
    productId: json['productId']
  );
    
  

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['amount'] = amount;
    _data['userId'] = userId;
    _data['productId'] = productId;
    return _data;
  }
}