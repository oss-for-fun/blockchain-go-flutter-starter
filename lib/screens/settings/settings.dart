import 'package:blockchain_starter/services/blockchain_starter.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  String chainId = 'Solana';
  String address = '';
  String privateKey = '';

  String endpoint = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void saveKasCredentials() async {
    final result = await saveSettings(chainId, address, privateKey);
    print(result);
  }

  void refreshContract() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 100.0,
        width: 100.0,
        child: FittedBox(
          child: FloatingActionButton(
            child: Icon(
              Icons.save,
              size: 40.0,
            ),
            tooltip: 'Save',
            onPressed: () => {saveKasCredentials()},
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Settings',
              style: Theme.of(context).textTheme.headline1,
            ),
            Padding(padding: const EdgeInsets.only(top: 100.0)),
            Center(
              child: DropdownButton<String>(
                hint: Text('Network ID'),
                value: chainId,
                icon: const Icon(Icons.arrow_downward),
                isExpanded: true,
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    chainId = newValue!;
                  });
                },
                items: <String>['Solana', 'Cosmos']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 20.0)),
            Center(
              child: TextField(
                controller: TextEditingController(text: address),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Address',
                ),
                onChanged: (String? value) {
                  setState(() {
                    address = value!;
                  });
                },
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 20.0)),
            Center(
              child: TextField(
                controller: TextEditingController(text: privateKey),
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Private Key',
                ),
                onChanged: (String? value) {
                  setState(() {
                    privateKey = value!;
                  });
                },
              ),
            ),
            Padding(padding: const EdgeInsets.only(top: 50.0)),
            Center(
              child: TextFormField(
                controller: TextEditingController(text: endpoint),
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Node Endpoint',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
