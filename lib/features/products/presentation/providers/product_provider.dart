
import 'package:flutter/material.dart';
import 'package:ushopie_ecom/features/products/data/models/products_model.dart';

class ProductProvider extends ChangeNotifier {

  late ProductModel _product;

  ProductModel get product => _product;

  void setProduct (ProductModel product) {
    _product = product;
    notifyListeners();
  } 
}