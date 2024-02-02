
import 'package:ushopie_ecom/features/products/domain/entity/products.dart';

class ProductModel extends Product {
  ProductModel({
    required int id,
    required String title,
    String? subTitle,
    required int price,
    required String description,
    required String category,
    required String thumbNail,
    required List<dynamic> sideImages,
    required String createdDate,
  }) : super(
          id: id,
          title: title,
          subTitle: subTitle!,
          price: price,
          description: description,
          category: category,
          thumbNail: thumbNail,
          sideImages: sideImages,
          createdDate: createdDate,
        );

  ProductModel.fromJson(Map<String, dynamic> json)
      : super(
          id: json['id'],
          title: json['title'],
          subTitle: json['subTitle'],
          price: json['price'],
          description: json['description'],
          category: json['category'],
          thumbNail: json['thumbNail'],
          sideImages: List<dynamic>.from(json['sideImages']),
          createdDate: json['createdDate'],
        );

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['subTitle'] = subTitle;
    _data['price'] = price;
    _data['description'] = description;
    _data['category'] = category;
    _data['thumbNail'] = thumbNail;
    _data['sideImages'] = sideImages;
    _data['createdDate'] = createdDate;
    return _data;
  }
}