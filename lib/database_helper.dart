import 'package:postgres/postgres.dart';
import 'order_page.dart';

Future<PostgreSQLConnection> createConnection() async {
  final connection = PostgreSQLConnection(
    'localhost', // Replace with your host
    5432, // Default PostgreSQL port
    'Food Delivery App', // Your database name
    username: 'postgres', // Replace with your database user
    password: '11322433', // Replace with your database password
  );

  await connection.open();
  return connection;
}

Future<void> registerUser(String email, String password) async {
  final connection = await createConnection();

  try {
    await connection.query(
      'INSERT INTO users (email, password) VALUES (@email, @password)',
      substitutionValues: {
        'email': email,
        'password': password,
      },
    );

    print('User registered successfully!');
  } catch (e) {
    print('Error: $e');
  }

  await connection.close();
}

Future<bool> loginUser(String email, String password) async {
  final connection = await createConnection();

  try {
    final result = await connection.query(
      'SELECT * FROM users WHERE email = @email',
      substitutionValues: {'email': email},
    );

    await connection.close();

    if (result.isNotEmpty && result.first[2] == password) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    print('Error: $e');
    return false;
  }
}

Future<void> saveOrder(String userId, List<FoodItem> selectedFoods, double total) async {
    final connection = await createConnection();

    try {
      await connection.query(
        'INSERT INTO orders (user_id, food_items, total) VALUES (@userId, @foodItems, @total)',
        substitutionValues: {
          'userId': userId,
          'foodItems': selectedFoods.map((food) => '${food.name} - \$${food.price.toStringAsFixed(2)}').join('\n'),
          'total': total,
        },
      );

      print('Order saved successfully!');
    } catch (e) {
      print('Error: $e');
    }

    await connection.close();
  }
