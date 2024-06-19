import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Settings"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text("Account", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          ListTile(
            title: Text("Change password"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Content settings"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Social"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Language"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Privacy and security"),
            onTap: () {},
          ),
          SizedBox(height: 20),
          ListTile(
            title: Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          SwitchListTile(
            title: Text("New for you"),
            value: true,
            onChanged: (bool value) {},
          ),
          SwitchListTile(
            title: Text("Account activity"),
            value: true,
            onChanged: (bool value) {},
          ),
          SwitchListTile(
            title: Text("Opportunity"),
            value: false,
            onChanged: (bool value) {},
          ),
          SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Sign out logic
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                side: BorderSide(color: Colors.grey),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              ),
              child: Text("SIGN OUT"),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SettingsPage(),
  ));
}
