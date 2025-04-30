import 'package:flutter/material.dart';
import 'tracking_screen.dart';

class OrderPage extends StatefulWidget {
  final List<FoodItem> selectedFoods;
  final double total;

  OrderPage({required this.selectedFoods, required this.total});

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String paymentMethod = 'Credit Card'; // Default payment method

  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void _showPaymentMethodDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Payment Method'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile(
                title: Text('Credit Card'),
                value: 'Credit Card',
                groupValue: paymentMethod,
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value.toString();
                  });
                  Navigator.pop(context);
                },
              ),
              RadioListTile(
                title: Text('Cash'),
                value: 'Cash',
                groupValue: paymentMethod,
                onChanged: (value) {
                  setState(() {
                    paymentMethod = value.toString();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showConfirmationDialog() {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Order Confirmation'),
        content: Text('Your order has been placed and is on its way!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: Text('Go Back'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the confirmation dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrderTrackingScreen(), // Navigate to order tracking screen
                ),
              );
            },
            child: Text('Track Order'),
          ),
        ],
      );
    },
  );
}


  @override
  void dispose() {
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Payment Method:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: _showPaymentMethodDialog,
              child: Text(paymentMethod),
            ),

            SizedBox(height: 20),

            Text(
              'Enter Address:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: 'Enter your address',
              ),
            ),

            SizedBox(height: 20),

            Text(
              'Enter Phone Number:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Enter your phone number',
              ),
            ),

            SizedBox(height: 20),

            Text(
              'Order List:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.selectedFoods
                  .map((food) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text('${food.name} - \$${food.price.toStringAsFixed(2)}'),
                      ))
                  .toList(),
            ),

            SizedBox(height: 10),

            Text(
              'Total: \$${widget.total.toStringAsFixed(2)}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Spacer(),

             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog(); // Show order confirmation dialog
                  },
                  child: Text('Complete Order'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back
                  },
                  child: Text('Go Back'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Order {
  final int orderId;
  final double total;
  final List<FoodItem> items;

  Order({
    required this.orderId,
    required this.total,
    required this.items,
  });
}

class FoodItem {
  final String name;
  final double price;

  FoodItem({required this.name, required this.price});
}