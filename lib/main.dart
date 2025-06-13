import 'package:flutter/material.dart';
import 'api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ErrorHandling(),
      title: "Error Handling And HTTP Status Responses",
    );
  }
}

class ErrorHandling extends StatefulWidget {
  const ErrorHandling({super.key});

  @override
  State<ErrorHandling> createState() => _ErrorHandlingDemoState();
}

class _ErrorHandlingDemoState extends State<ErrorHandling> {
  final TextEditingController _controller = TextEditingController();
  String _result = '';

  void fetchUserByName() async {
    setState(() => _result = 'Loading...');

    final name = _controller.text.trim();
    if (name.isEmpty) {
      setState(() => _result = 'Error: Name field is required');
      return;
    }

    final response = await ApiService.searchUserByName(name);

    if (response.containsKey('data')) {
      setState(() {
        _result =
            'Found: ${response['data']['name']}\nEmail: ${response['data']['email']}';
      });
    } else {
      setState(() {
        _result = 'Error (${response['status']}): ${response['error']}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Error Handling, HTTP Status Responses',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Enter User Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchUserByName,
              child: const Text(
                'Search',
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, 
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
