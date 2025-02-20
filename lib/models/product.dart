// product item
class Product {
  final String name;              // aiglasses gen1
  final String description;       // a glasses specially designed for blind person 
  final String imagePath;   
  final double price;             // not final(7999)
  final ProductCategory category; // ai glass
  List<Addon> availableAddons;    // [charger , lens ]

  Product({
    required this.name,
    required this.description,
    required this.imagePath,
    required this.price,
    required this.category,
    required this.availableAddons,
  });
}

// product categories
enum ProductCategory {
  aiglasses,
  lenses,
  chargers,
}

class Addon {
  String name;
  double price;

  Addon({
    required this.name,
    required this.price,
  });
}
