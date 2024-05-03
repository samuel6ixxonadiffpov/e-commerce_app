class Product {
  final String name, desc, image, unit, category;
  final double price, rating;
  final bool available;
  final String productId;
  const Product({
    required this.productId,
    required this.name,
    required this.desc,
    required this.image,
    required this.price,
    required this.rating,
    required this.unit,
    required this.available,
    required this.category,
  });
}
