import 'package:flutter/material.dart';
import '../models/product.dart';

class MyProductTile extends StatelessWidget {
  final Product product;
  final void Function()? onTap;

  const MyProductTile({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    product.imagePath,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 15),

                // Text product details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '₹${product.price.toString()}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        product.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Divider line
        Divider(
          color: Colors.grey.shade400,
          thickness: 1,
          indent: 20,
          endIndent: 20,
        ),
      ],
    );
  }
}

// url= ("https://youtu.be/dQw4w9WgXcQ?si=k0K2fZc3Kg3F3eZd")
