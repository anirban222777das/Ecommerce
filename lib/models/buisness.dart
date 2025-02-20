import 'package:blinders/models/cart_items.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'product.dart';

class Buisness extends ChangeNotifier {
  final List<Product> _menu = [
    // AI Glasses
    Product(
      name: "Gen1 AI Glasses",
      description:
          "A sleek and futuristic wearable designed to seamlessly integrate with your daily life.",
      imagePath: "lib/images/aiglasses/pic1.jpg",
      price: 4999,
      category: ProductCategory.aiglasses,
      availableAddons: [
        Addon(name: "Charger", price: 599),
        Addon(name: "Lenses", price: 299),
      ],
    ), // Gen1 AI Glasses

    Product(
      name: "Gen2 AI Glasses",
      description:
          "An upgraded version of the Gen1, with enhanced features and better performance.",
      imagePath: "lib/images/aiglasses/pic2.jpg",
      price: 5999,
      category: ProductCategory.aiglasses,
      availableAddons: [
        Addon(name: "Charger", price: 699),
        Addon(name: "Lenses", price: 349),
      ],
    ), // Gen2 AI Glasses

    // Chargers
    Product(
      name: "Charger",
      description: "A reliable charger designed for the AI glasses.",
      imagePath: "lib/images/chargers/charger1.jpg",
      price: 599,
      category: ProductCategory.chargers,
      availableAddons: [],
    ), // Charger

    // Lenses
    Product(
      name: "Lenses",
      description: "High-quality lenses for clear vision with AI glasses.",
      imagePath: "lib/images/lenses/lens.jpg",
      price: 299,
      category: ProductCategory.lenses,
      availableAddons: [],
    ), // Lenses
  ];

  // User cart
  final List<CartItems> _cart = [];

  // delivery address (which user can change/update)
  String _deliveryAddress = 'Majherhati,1st lane';

  /*
  
  G E T T E R S
  
  */
  List<Product> get menu => _menu;
  List<CartItems> get cart => _cart;
  String get deliveryAddress => _deliveryAddress;

  /*
  
  O P E R A T I O N S 
  
  */

  // Add to cart
  void addTocart(Product product, List<Addon> selectedAddons) {
    // See if there is already a cart item with the same product and selected addons
    CartItems? cartItem = _cart.firstWhereOrNull((item) {
      // Check if the product items are the same
      bool isSameProduct = item.product == product;

      // Check if the list of selected addons are the same
      bool isSameAddons =
          const ListEquality().equals(item.selectedAddons, selectedAddons);

      return isSameProduct && isSameAddons;
    });

    // If the item already exists, just increase the quantity
    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      // Otherwise, add a new cart item
      _cart.add(
        CartItems(
          product: product,
          selectedAddons: selectedAddons,
        ),
      );
    }
    notifyListeners();
  }

  // Remove from cart
  void removeFromCart(CartItems cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }

    notifyListeners();
  }

  // Get total price of cart
  double getTotalPrice() {
    double totalPrice = 0.0;
    for (CartItems cartItem in _cart) {
      totalPrice += cartItem.totalPrice; // Use the getter from CartItems
    }
    return totalPrice;
  }

  // Get total number of items in cart
  int getTotalItemCount() {
    int totalItemCount = 0;
    for (CartItems cartItem in _cart) {
      totalItemCount += cartItem.quantity;
    }
    return totalItemCount;
  }

  // Clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

// update delivery address
  void updateDeliveryAddress(String newAddress) {
    _deliveryAddress = newAddress;
    notifyListeners();
  }

/*
H E L P E R S



*/

// generate a receipt
  String displayCartReceipt() {
    final receipt = StringBuffer();
    receipt.writeln("Here's your receipt. ");
    receipt.writeln();

    // format the date to include up to seconds only
    String formattedDate =
        DateFormat('yyy-MM-dd HH:mm:ss').format(DateTime.now());

    receipt.writeln(formattedDate);
    receipt.writeln();
    receipt.writeln("------------------");

    for (final CartItems in _cart) {
      receipt.writeln(
          "${CartItems.product.name} x ${CartItems.quantity} - ${_formatPrice(CartItems.product.price)} ");
      if (CartItems.selectedAddons.isNotEmpty) {
        receipt
            .writeln("   Add-ons: ${_formatAddons(CartItems.selectedAddons)}");
      }
      receipt.writeln();
    }
    receipt.writeln("------------------");
    receipt.writeln("Total Items: ${getTotalItemCount()}");
    receipt.writeln("Total Price: ${_formatPrice(getTotalPrice())}");
    receipt.writeln();
    receipt.writeln("Delivery to:$deliveryAddress");

    return receipt.toString();
  }

// format double value into money
  String _formatPrice(double price) {
    return "₹${price.toStringAsFixed(2)}";
  }

// format list of addons into a string summary
  String _formatAddons(List<Addon> addon) {
    return addon
        .map((addon) => "${addon.name} (${_formatPrice(addon.price)})")
        .join(", ");
  }
}
