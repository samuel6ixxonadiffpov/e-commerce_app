import 'package:agricapp/data/cart.dart';

final _instance = CartController._();

class CartController {
  List<CartModel> cart = [];
  static CartController getInstance() {
    return _instance;
  }

  void push(CartModel cartModel) {
    try {
      cart
          .firstWhere((element) => element.productId == cartModel.productId)
          .quantity += cartModel.quantity;
    } catch (_) {
      cart.add(cartModel);
    }
  }

  void remove(String productId) {
    cart.removeWhere((element) => element.productId == productId);
  }

  CartController._();
}
