import 'package:flutter/material.dart';
import 'package:mic_fuel/src/home.dart';

class userProfile extends StatefulWidget {
  const userProfile({Key? key}) : super(key: key);

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  int _selectedIndex = 2;

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
                    icon: Icon(Icons.oil_barrel),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                  label: 'Fuel',
                  backgroundColor: Colors.green),
              BottomNavigationBarItem(
                  icon: Icon(Icons.car_repair),
                  label: 'Stations',
                  backgroundColor: Colors.yellow),
              BottomNavigationBarItem(
                icon: IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => userProfile()),
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
          title: Text('My Profile'),
          centerTitle: true,
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60, bottom: 35),
                child: Container(
                  width: 159,
                  height: 159,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://avatars.githubusercontent.com/u/96121069?v=4'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(90.0)),
                    border: Border.all(
                      color: Colors.blue,
                      width: 4.0,
                    ),
                  ),
                ),
              ),
              const Text(
                'Karim Kurda',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 60, top: 15, right: 60),
                child: Center(
                  child: Text(
                    'Programmer, Front-End Developer and Freelancer.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myWidget(
      {required String text, required Color color, required Widget icon}) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Container(
        height: 54,
        width: 299,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: icon,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 80.0),
              child: Text(
                text,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget myContainer({required IconData icon, required Color color}) {
  return Container(
    margin: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      color: color,
      boxShadow: const [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.25),
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    width: 40,
    height: 40,
    child: Center(
      child: Icon(icon),
    ),
  );
}
