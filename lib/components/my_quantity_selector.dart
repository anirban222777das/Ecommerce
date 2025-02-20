import 'package:flutter/material.dart';
import '../models/product.dart';

class MyQuantitySelector extends StatelessWidget {
  final int quantity;
  final Product product;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const MyQuantitySelector({
    super.key,
    required this.quantity,
    required this.product,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(50),
      ),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Decrease button
          GestureDetector(
            onTap: onDecrement,
            child: Icon(
              Icons.remove,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          // Quantity count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SizedBox(
              width: 20,
              child: Center(
                child: Text(
                  quantity.toString(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),

          // Increase button
          GestureDetector(
            onTap: onIncrement, // Fixed to use onIncrement
            child: Icon(
              Icons.add,
              size: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
