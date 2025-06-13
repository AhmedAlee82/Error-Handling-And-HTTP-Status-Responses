import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  static Future<Map<String, dynamic>> searchUserByName(String name) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/users'));

      if (response.statusCode == 200) {
        List users = jsonDecode(response.body);
        final matchedUser = users.firstWhere(
          (user) => user['name'].toString().toLowerCase() == name.toLowerCase(),
          orElse: () => null,
        );

        if (matchedUser != null) {
          return {'data': matchedUser};
        } else {
          return {'error': "Route not found", 'status': 404};
        }
      } else {
        return {'error': 'Unexpected server error', 'status': response.statusCode};
      }
    } catch (e) {
      return {'error': 'Something went wrong: $e', 'status': 500};
    }
  }
}
