import 'package:blinders/models/buisness.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCurrentLocation extends StatefulWidget {
  const MyCurrentLocation({super.key});

  @override
  State<MyCurrentLocation> createState() => _MyCurrentLocationState();
}

class _MyCurrentLocationState extends State<MyCurrentLocation> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void openLocationSearchBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Your Location"),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(hintText: "Enter address..."),
        ),
        actions: [
          // Cancel button
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          // Save button
          MaterialButton(
            onPressed: () {
              // Update delivery address
              String newAddress = textController.text.trim();
              if (newAddress.isNotEmpty) {
                context.read<Buisness>().updateDeliveryAddress(newAddress);
              }
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Deliver now",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          GestureDetector(
            onTap: () => openLocationSearchBox(context),
            child: Row(
              children: [
                // Address
                Consumer<Buisness>(
                  builder: (context, buisness, child) => Text(
                    buisness.deliveryAddress,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Dropdown menu
                const Icon(Icons.keyboard_arrow_down_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
