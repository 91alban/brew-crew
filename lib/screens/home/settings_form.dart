import 'package:flutter/material.dart';
import 'package:guru4cars/models/user.dart';
import 'package:guru4cars/services/database.dart';
import 'package:guru4cars/shared/loading.dart';
import 'package:provider/provider.dart';
import '../../shared/constants.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

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
    final user = Provider.of<UserData>(context);
    return StreamBuilder<UserModel>(
        stream: DatabaseService(uid: user.uid.toString()).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserModel? userModel = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(children: [
                const Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userModel!.name,
                  decoration: textInputDecoration,
                  validator: (val) =>
                      val!.isEmpty ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                const SizedBox(height: 20.0),
                DropdownButtonFormField<String>(
                  value: _currentSugars ?? userModel.sugars,
                  decoration: textInputDecoration,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('$sugar sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val!),
                ),
                const SizedBox(height: 20.0),
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _currentStrength = val.round()),
                  value: (_currentStrength ?? userModel.strength).toDouble(),
                  activeColor:
                      Colors.brown[_currentStrength ?? userModel.strength],
                  inactiveColor:
                      Colors.brown[_currentStrength ?? userModel.strength],
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  child: const Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid.toString())
                          .updateUserData(
                        _currentSugars ?? userModel.sugars,
                        _currentName ?? userModel.name,
                        _currentStrength ?? userModel.strength,
                      );
                      Navigator.pop(context);
                    }
                  },
                )
              ]),
            );
          } else {
            return Loading();
          }
        });
  }
}
