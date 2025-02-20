import 'package:blinders/models/product.dart';

class CartItems {
  Product product;
  List<Addon> selectedAddons;
  int quantity;

  CartItems({
    required this.product,
    required this.selectedAddons,
    this.quantity = 1,
  });

  double get totalPrice {
    double addonsPrice =
        selectedAddons.fold(0, (sum, addon) => sum + addon.price);
        return (product.price + addonsPrice)* quantity;
  }
}
