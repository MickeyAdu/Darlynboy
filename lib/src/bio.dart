import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Bio extends StatefulWidget {
  final String image;
  final String name;
  final String bio;
  const Bio(
      {Key? key, required this.image, required this.name, required this.bio})
      : super(key: key);

  @override
  State<Bio> createState() => _BioState();
}

class _BioState extends State<Bio> {
  String _selectedGasType = 'Super';
  TextEditingController quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: const Text(
            'Speed Stop',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: BackButton(
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            Expanded(
              child: Container(
                height: 250.0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                padding: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade900,
                    offset: const Offset(0, 3),
                    blurRadius: 9,
                    spreadRadius: 3,
                  ),
                ]),
              ),
            ),
            Container(
              height: 10.0,
            ), //space between image ain Erbil text
            Container(
              height: 50.0,
              child: Text(
                widget.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: Text(
                widget.bio,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(5, 15, 5, 15)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Choose your fuel type:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ListTile(
                  leading: Radio<String>(
                    value: 'Super',
                    groupValue: _selectedGasType,
                    onChanged: (value) {
                      setState(() {
                        _selectedGasType = value!;
                      });
                    },
                  ),
                  title: const Text('Super',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  leading: Radio<String>(
                    value: 'Improved',
                    groupValue: _selectedGasType,
                    onChanged: (value) {
                      setState(() {
                        _selectedGasType = value!;
                      });
                    },
                  ),
                  title: const Text('Improved',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  leading: Radio<String>(
                    value: 'Normal',
                    groupValue: _selectedGasType,
                    onChanged: (value) {
                      setState(() {
                        _selectedGasType = value!;
                      });
                    },
                  ),
                  title: const Text('Normal',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.fromLTRB(5, 15, 5, 15)),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: quantityController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Liters (0 - 60)',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^([1-5]?[0-9]|[0-9])$|^60$'),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                child: const Text(
                  'Checkout!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  // Get the selected gas type and quantity entered by the user
                  final String gasType = _selectedGasType;
                  final int quantity =
                      int.tryParse(quantityController.text) ?? 0;

                  // Calculate the total price based on the gas type and quantity
                  int pricePerLiter = 0;
                  switch (gasType) {
                    case 'Normal':
                      pricePerLiter = 800;
                      break;
                    case 'Improved':
                      pricePerLiter = 1000;
                      break;
                    case 'Super':
                      pricePerLiter = 1250;
                      break;
                  }
                  final int totalPrice = pricePerLiter * quantity;

                  // Navigate to the order confirmation page and pass the total price
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Order(
                              totalPrice,
                              gasType: _selectedGasType,
                              quantity: quantity,
                            )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Order extends StatefulWidget {
  final String gasType;
  final int quantity;

  const Order(int totalPrice,
      {Key? key, required this.gasType, required this.quantity})
      : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  late int _totalPrice;

  @override
  void initState() {
    super.initState();
    _totalPrice = calculatePrice();
  }

  int calculatePrice() {
    if (widget.gasType == 'Normal') {
      return widget.quantity * 800;
    } else if (widget.gasType == 'Improved') {
      return widget.quantity * 1000;
    } else {
      return widget.quantity * 1250;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: AppBar(
        title: const Text(
          'Order Summary',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Your order summary:',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'Gas type: ${widget.gasType}',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Quantity: ${widget.quantity} liters',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 10),
                Text(
                  'Total price: $_totalPrice IQD',
                  style: const TextStyle(fontSize: 18),
                ),
                Spacer(),
                Text(
                  'The truck is on way to You !',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
