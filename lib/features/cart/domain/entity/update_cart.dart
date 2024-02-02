
class UpdateCart {
  final String amount;
  final int userId;
  final String productId;

  UpdateCart({
    required this.amount,
    required this.userId,
    required this.productId
  });
}