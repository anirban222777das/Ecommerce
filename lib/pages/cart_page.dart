import 'package:blinders/components/my_button.dart';
import 'package:blinders/components/my_cart_tiles.dart';
import 'package:blinders/models/buisness.dart';
import 'package:blinders/pages/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Buisness>(
      builder: (context, buisness, child) {
        // cart
        final userCart = buisness.cart;

        // scaffold UI
        return Scaffold(
          appBar: AppBar(
            title: const Text("Cart"),
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              // Clear cart button
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Are you sure you want to clear the cart?"),
                      actions: [
                        // Cancel button
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel"),
                        ),
                        // Yes button
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            buisness.clearCart();
                          },
                          child: const Text("Yes"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
          body: Column(
            children: [
              // List of cart items
              Expanded(
                child: userCart.isEmpty
                    ? const Center(
                        child: Text(
                          "Cart is Empty..",
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        itemCount: userCart.length,
                        itemBuilder: (context, index) {
                          // Get individual cart item
                          final cartItem = userCart[index];
                          // Return cart tile UI
                          return MyCartTiles(cartItems: cartItem);
                        },
                      ),
              ),
              // Button to pay
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: MyButton(
                  onTap: ()=> Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentPage(),
                  ),
                  ),
                  text: "Go to Checkout",
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        );
      },
    );
  }
}
