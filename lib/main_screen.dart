import 'package:flutter/material.dart';
import 'order_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<String> foodTypes = ['Burger', 'Pizza', 'Chinese', 'Sushi'];

  // Map food types to icons
  final Map<String, IconData> foodTypeIcons = {
    'Burger': Icons.fastfood,
    'Pizza': Icons.local_pizza,
    'Chinese': Icons.rice_bowl,
    'Sushi': Icons.circle,
  };

  // Stores for each food type
  final Map<String, List<String>> storesMap = {
    'Burger': ['Burger Place 1', 'Burger Place 2'],
    'Pizza': ['Pizza Shop 1', 'Pizza Shop 2'],
    'Chinese': ['Chinese Restaurant 1', 'Chinese Restaurant 2'],
    'Sushi': ['Sushi Bar 1', 'Sushi Bar 2'],
  };

  void _openFeedbackDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Provide Feedback'),
          content: TextField(
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Enter your feedback here',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Process the feedback here (e.g., send it to a server)
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Delivery App'),
      ),
      body: Row(
        children: [
          // Navigation Rail
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            labelType: NavigationRailLabelType.all,
            destinations: [
              for (var foodType in foodTypes)
                NavigationRailDestination(
                  icon: Icon(foodTypeIcons[foodType]),
                  label: Text(foodType),
                ),
            ],
          ),
          // Content
          Expanded(
            child: Center(
              child: ListView.builder(
                itemCount: storesMap[foodTypes[_selectedIndex]]!.length,
                itemBuilder: (context, index) {
                  final storeName = storesMap[foodTypes[_selectedIndex]]![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StorePage(storeName: storeName, theme: Theme.of(context)),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(storeName),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openFeedbackDialog,
        tooltip: 'Provide Feedback',
        child: Icon(Icons.feedback),
      ),
    );
  }
}

class StorePage extends StatefulWidget {
  final String storeName;
  final ThemeData theme;

  StorePage({required this.storeName, required this.theme});

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  List<FoodItem> foodItems = [
    FoodItem(name: 'Food Item 1', price: 5.99),
    FoodItem(name: 'Food Item 2', price: 7.49),
    FoodItem(name: 'Food Item 3', price: 3.99),
    // Add more food items with their prices
  ];

  List<FoodItem> selectedFoods = [];

  void _addToOrder(FoodItem foodItem) {
    setState(() {
      selectedFoods.add(foodItem);
    });
  }

  double _calculateTotal() {
    return selectedFoods.fold(0, (total, item) => total + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.storeName),
      ),
      body: Row(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: foodItems.length,
              itemBuilder: (context, index) {
                final foodItem = foodItems[index];
                return ListTile(
                  title: Text(foodItem.name),
                  subtitle: Text('\$${foodItem.price.toStringAsFixed(2)}'),
                  onTap: () {
                    _addToOrder(foodItem);
                  },
                );
              },
            ),
          ),
          Container(
            width: 200,
            color: Colors.grey[200],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  '\t\t\tCurrent Order:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: selectedFoods
                        .map((food) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: Text('${food.name} - \$${food.price.toStringAsFixed(2)}'),
                            ))
                        .toList(),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  '\t\t\tTotal: \$${_calculateTotal().toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderPage(
                            selectedFoods: selectedFoods,
                            total: _calculateTotal(),
                          ),
                        ),
                      );
                    },
                    child: Text('Place Order'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
