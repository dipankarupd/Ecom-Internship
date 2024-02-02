class UpdateWishlistModel {
  UpdateWishlistModel({
    required this.wishList,
    required this.userId,
  });
  late final String wishList;
  late final String userId;
  
  UpdateWishlistModel.fromJson(Map<String, dynamic> json){
    wishList = json['wishList'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['wishList'] = wishList;
    _data['userId'] = userId;
    return _data;
  }
}