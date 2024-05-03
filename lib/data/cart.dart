class CartModel {
  final double price;
  int quantity;
  final double discount;
  final String productName;
  final String productId, productImage;

  CartModel({
    required this.price,
    required this.quantity,
    required this.discount,
    required this.productName,
    required this.productId,
    required this.productImage,
  });
  void setQuantity(int quantity) {
    this.quantity = quantity;
  }
}
