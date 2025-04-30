import 'package:flutter/material.dart';

class ShopsScreen extends StatelessWidget {
  final String foodType;

  ShopsScreen({required this.foodType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shops'),
      ),
      body: Center(
        child: Text('This is the list of shops for ${foodType}.'),
      ),
    );
  }
}