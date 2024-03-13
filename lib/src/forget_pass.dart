import 'package:flutter/material.dart';


class forgetpass extends StatelessWidget {  
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(
      backgroundColor: Colors.amber,  
      appBar: AppBar(  
        title: const Text('Speed Stop'),centerTitle: true,  
      ),  
      body: Padding(padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 50)),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Welcome to fuel delivery',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                )),
            const Padding(padding: EdgeInsets.only(top: 40)),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Reset Password',
                  style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone Number',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  child: const Text('Reset Password',style: TextStyle(fontWeight: FontWeight.bold)),
                  onPressed: () {
                    print(nameController.text);
                    print(emailController.text);
                    print(phoneController.text);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password has been reset"),));
                    Navigator.of(context).pop(); 
                  },
                )
            ),
            
          ],
        )  
    ));  
  }  
} 