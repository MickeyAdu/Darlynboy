import 'package:flutter/material.dart';
import 'package:mic_fuel/mock/mock.dart';
import 'package:mic_fuel/src/bio.dart';
import 'package:mic_fuel/src/profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: IconButton(
                    icon: const Icon(Icons.oil_barrel),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Home()),
                      );
                    },
                  ),
                  label: 'Fuel',
                  backgroundColor: Colors.green),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.car_repair),
                  label: 'Stations',
                  backgroundColor: Colors.yellow),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const userProfile()),
                    );
                  },
                ),
                label: 'Account',
                backgroundColor: Colors.blue,
              ),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            iconSize: 40,
            onTap: _onItemTapped,
            elevation: 5),
        backgroundColor: Colors.amber,
        appBar: AppBar(
          title: const Text('Fuel Me'),
          centerTitle: true,
        ),
        body: Center(
          child: SafeArea(
            child: ListView.builder(
                itemCount: mockData.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    child: Card(
                      elevation: 15,
                      shadowColor: Colors.grey,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Ink.image(
                            image:
                                AssetImage(mockData[index]["image"].toString()),
                            height: 200,
                            fit: BoxFit.cover,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Bio(
                                              image: mockData[index]["image"]
                                                  .toString(),
                                              name: mockData[index]["name"]
                                                  .toString(),
                                              bio: mockData[index]["bio"]
                                                  .toString(),
                                            )));
                              },
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      bottomRight: Radius.circular(15),
                                      topRight: Radius.circular(5)),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 3),
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 9,
                                    )
                                  ]),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Bio(
                                                image: mockData[index]["image"]
                                                    .toString(),
                                                name: mockData[index]["name"]
                                                    .toString(),
                                                bio: mockData[index]["bio"]
                                                    .toString(),
                                              )));
                                },
                                child: Center(
                                  child: Text(
                                    mockData[index]["name"].toString(),
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
