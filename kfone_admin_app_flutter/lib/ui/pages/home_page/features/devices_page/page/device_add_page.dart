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
      final url = 'https://yourbackend.com/yourendpoint';
      final response = await http.post(Uri.parse(url), body: {
        'field1': _controller1.text,
        'field2': _controller2.text,
        'field3': _controller3.text,
        'field4': _controller4.text,
        'field5': _controller5.text,
      });

      if (response.statusCode == 200) {
        // Handle success
        print('Data sent successfully!');
      } else {
        // Handle failure
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
                  labelText: 'Field 1',
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
                  labelText: 'Field 2',
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
                  labelText: 'Field 3',
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
                  labelText: 'Field 4',
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
                  labelText: 'Field 5',
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
