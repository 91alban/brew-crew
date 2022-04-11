import 'package:flutter/material.dart';
import '../../shared/constants.dart';

class SettingsForm extends StatefulWidget {
  SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String? _currentName;
  String? _currentSugars;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: [
        const Text(
          'Update your brew settings.',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 20.0),
        TextFormField(
          decoration: textInputDecoration,
          validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
          onChanged: (val) => setState(() => _currentName = val),
        ),
        SizedBox(height: 20.0),
        DropdownButtonFormField<String>(
          value: _currentSugars,
          decoration: textInputDecoration,
          items: sugars.map((sugar) {
            return DropdownMenuItem(
              value: sugar,
              child: Text('$sugar sugars'),
            );
          }).toList(),
          onChanged: (val) => setState(() => _currentSugars = val!),
        ),
        SizedBox(height: 20.0),
        Slider(
          min: 100,
          max: 900,
          divisions: 8,
          onChanged: (val) => setState(() => _currentStrength = val.round()),
          value: (_currentStrength ?? 100).toDouble(),
          activeColor: Colors.brown[_currentStrength ?? 100],
          inactiveColor: Colors.brown[_currentStrength ?? 100],
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          child: Text(
            'Update',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () async {
            print(_currentName);
            print(_currentSugars);
            print(_currentStrength);
          },
        )
      ]),
    );
  }
}