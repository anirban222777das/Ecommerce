import 'package:blinders/components/my_button.dart';
import 'package:blinders/models/buisness.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  final Map<Addon, bool> selectedAddons = {};

  ProductPage({
    super.key,
    required this.product,
  }) {
    // Initialize selected addons to be false
    for (Addon addon in product.availableAddons) {
      selectedAddons[addon] = false;
    }
  }

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // method to add to cart
  void addToCart(Product product, Map<Addon, bool> selectedAddons) {
    // close the current product page to go back to menu
    Navigator.pop(context);

    // format the selected addons
    List<Addon> currentlySelectedAddons = [];
    for (Addon addon in widget.product.availableAddons) {
      if (widget.selectedAddons[addon] == true) {
        currentlySelectedAddons.add(addon);
      }
    }
    // add to cart 
    context.read<Buisness>().addTocart(product, currentlySelectedAddons);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scaffold UI
        Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Product image
                Image.asset(widget.product.imagePath),

                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product name
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),

                      // Product price
                      Text(
                        '₹${widget.product.price}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Product description
                      Text(widget.product.description),

                      const SizedBox(height: 10),

                      Divider(color: Theme.of(context).colorScheme.secondary),

                      const SizedBox(height: 10),

                      // Add-ons
                      Text(
                        "Add-ons",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).colorScheme.secondary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: widget.product.availableAddons.length,
                          itemBuilder: (context, index) {
                            // Get individual addon
                            Addon addon = widget.product.availableAddons[index];
                            // Return checkbox UI
                            return CheckboxListTile(
                              title: Text(addon.name),
                              subtitle: Text(
                                '₹${addon.price}',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              value: widget.selectedAddons[addon],
                              onChanged: (bool? value) {
                                setState(() {
                                  widget.selectedAddons[addon] = value!;
                                });
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),

                // Button -> add to cart
                MyButton(
                  onTap: () => addToCart(widget.product, widget.selectedAddons),
                  text: "Add to Cart",
                ),

                const SizedBox(height: 25),
              ],
            ),
          ),
        ),

        // Back button
        SafeArea(
          child: Opacity(
            opacity: 0.6,
            child: Container(
              margin: const EdgeInsets.only(left: 25),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_rounded),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
