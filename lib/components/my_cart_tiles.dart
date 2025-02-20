import 'package:blinders/components/my_quantity_selector.dart';
import 'package:blinders/models/buisness.dart';
import 'package:blinders/models/cart_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCartTiles extends StatelessWidget {
  final CartItems cartItems;

  const MyCartTiles({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Consumer<Buisness>(
      builder: (context, buisness, child) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      cartItems.product.imagePath,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Name and price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product name
                      Text(
                        cartItems.product.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Product price
                      Text(
                        '₹${cartItems.product.price}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                              const SizedBox(height: 10),

                      // Increment/Decrement quantity
                  MyQuantitySelector(
                    quantity: cartItems.quantity,
                    product: cartItems.product,
                    onIncrement: () {
                      buisness.addTocart(
                          cartItems.product, cartItems.selectedAddons);
                    },
                    onDecrement: () {
                      buisness.removeFromCart(cartItems);
                    },
                  ),




                    ],
                  ),
                  const Spacer(),
                  
                ],
              ),
            ),
            // Add-ons
            if (cartItems.selectedAddons.isNotEmpty)
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.only(left: 10, bottom: 10, right: 10),
                  children: cartItems.selectedAddons
                      .map(
                        (addon) => Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: FilterChip(
                            label: Row(
                              children: [
                                // Add-on name
                                Text(addon.name),
                                // Add-on price
                                Text(' (₹${addon.price})'),
                              ],
                            ),
                            shape: StadiumBorder(
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            onSelected: (value) {},
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            labelStyle: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .inversePrimary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
