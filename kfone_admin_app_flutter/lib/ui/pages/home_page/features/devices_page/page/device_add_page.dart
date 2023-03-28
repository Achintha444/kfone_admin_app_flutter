import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeviceAddPage extends StatefulWidget {
  const DeviceAddPage({super.key});

  @override
  _DeviceAddPageState createState() => _DeviceAddPageState();
}

class _DeviceAddPageState extends State<DeviceAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();
  final _controller5 = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final url = 'https://divine-snowflake-5579.fly.dev/devices';
      final headers = {'Authorization': 'Bearer <token>',
        'Content-Type': 'application/json'};
      final body = jsonEncode({
        'name': _controller1.text,
        'image_uri': _controller2.text,
        'qty': int.parse(_controller3.text),
        'description': _controller4.text,
        'price': double.parse(_controller5.text),
      });
      final response = await http.post(Uri.parse(url),headers: headers, body: body);

      if (response.statusCode == 201) {
        // Handle success
        print('Device Added!');
      } else {
        // Handle failure
        print(response.statusCode);
        print('Failed to send data!');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Device'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _controller1,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              TextFormField(
                controller: _controller2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Image URL',
                ),
              ),
              TextFormField(
                controller: _controller3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Quantity',
                ),
              ),
              TextFormField(
                controller: _controller4,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Descpription',
                ),
              ),
              TextFormField(
                controller: _controller5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
