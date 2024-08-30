import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mic_fuel/screens/notify.dart';
import 'package:mic_fuel/src/Drawer%20Sections/Dashboard.dart';
import 'package:mic_fuel/src/Drawer%20Sections/MyHeaderDrawer.dart';
import 'package:mic_fuel/screens/Setting.dart';
import 'package:mic_fuel/screens/Support.dart';
import 'package:mic_fuel/src/Drawer%20Sections/about.dart';
import 'package:mic_fuel/screens/main_home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mic_fuel/src/Drawer%20Sections/Orders.dart';
import 'package:mic_fuel/src/Drawer%20Sections/offer.dart';
import 'package:mic_fuel/src/Drawer%20Sections/payment.dart';
import 'package:mic_fuel/src/Drawer%20Sections/referandearn.dart';
import 'package:mic_fuel/src/Drawer%20Sections/wallet.dart';
import 'package:mic_fuel/screens/history.dart';
import 'package:mic_fuel/screens/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentPage = DrawerSections.home;
  bool drawerOrNav = false;
  String _username = "User"; // Default name
  final _selectedIndex = ValueNotifier<int>(0);
  // late int notificationCount;
  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  void _fetchUserName() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (userData.exists) {
          setState(() {
            _username = userData["first_name"] ?? 'user';
          });
        } else {
          setState(() {
            _username = 'user';
          });
        }
      } catch (e) {
        print("Error fetching user data: $e");
        setState(() {
          _username = 'user';
        });
      }
    } else {
      setState(() {
        _username = 'user';
      });
    }
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var container;

    if (currentPage == DrawerSections.home) {
      container = HomeScreen();
    } else if (currentPage == DrawerSections.about) {
      container = AboutPage();
    } else if (currentPage == DrawerSections.payment) {
      container = PaymentPage();
    } else if (currentPage == DrawerSections.support) {
      container = SupportPage();
    } else if (currentPage == DrawerSections.logout) {
      container = const MyOrders();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome $_username',
          style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w300),
        ),
        actions: [
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            icon: const Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            },
          ),
          // NotificationButton(notificationCount: notificationCount),
        ],
      ),
      body: drawerOrNav
          ? container
          : ValueListenableBuilder<int>(
              valueListenable: _selectedIndex,
              builder: (context, selectedIndex, child) {
                switch (selectedIndex) {
                  case 0:
                    return const HomeScreen(); // Replace with your home page widget
                  case 1:
                    return const HistoryPage(); // Replace with your history page widget
                  case 2:
                    return const SettingPage();
                  case 3:
                    return WalletPage(); // Replace with your settings page widget
                  default:
                    return const Center(child: Text('Error: Invalid Index'));
                }
              },
            ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              myListDrawer(),
              // SizedBox(
              //   height: 58.h,
              // ),
              Padding(
                padding: EdgeInsets.only(top: 270.0.h),
                child: TextButton(
                    onPressed: () => {
                          _logOut(),
                        },
                    child: const Text(
                      'Log Out',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 21,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: 0.5.h,
        width: double.infinity,
        color: Theme.of(context).colorScheme.primary,
      ),
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: GNav(
            backgroundColor: Colors.transparent,
            color: Theme.of(context).colorScheme.primary,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8.0,
            onTabChange: (index) => setState(() {
              _selectedIndex.value = index;
              drawerOrNav = false;
            }),
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.shopping_cart,
                text: 'History',
              ),
              GButton(
                icon: Icons.settings_outlined,
                text: 'Settings',
              ),
              GButton(
                icon: Icons.window_outlined,
                text: 'More',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myListDrawer() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        //Show the list of the menu DRAWER
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "Support", Icons.lightbulb,
              currentPage == DrawerSections.support ? true : false),
          menuItem(3, "Payment", Icons.attach_money_outlined,
              currentPage == DrawerSections.payment ? true : false),
          menuItem(4, "About", Icons.query_stats,
              currentPage == DrawerSections.about ? true : false),
          menuItem(5, "Orders", Icons.menu_open_outlined,
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[500] : Colors.transparent,
      borderRadius: BorderRadius.circular(5.r),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            drawerOrNav = true;
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.support;
            } else if (id == 3) {
              currentPage = DrawerSections.payment;
            } else if (id == 4) {
              currentPage = DrawerSections.about;
            } else if (id == 5) {
              currentPage = DrawerSections.logout;
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _logOut() {
    // Show a dialog to confirm logout
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // backgroundColor: Theme.of(context).colorScheme.tertiary,
          title: const Text('Confirm Logout'),
          titleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontFamily: 'Poppins',
              fontSize: 21,
              fontWeight: FontWeight.bold),
          content: const Text('Are you sure you want to log out?'),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue, // Blue background for "No"
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the modal
                    },
                    child: const Text(
                      'No',
                      style: TextStyle(color: Colors.white), // White text
                    ),
                  ),
                  // Yes button
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red, // Red background for "Yes"
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the modal
                      _confirmLogOut(); // Proceed with logout
                    },
                    child: const Text(
                      'Yes',
                      style: TextStyle(color: Colors.white), // White text
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void _confirmLogOut() async {
    // Clear user information and sign out
    await FirebaseAuth.instance.signOut();
    setState(() {
      _username = 'User';
    });

    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LogIn()),
    );
  }
}

enum DrawerSections {
  home,
  support,

  logout,
  payment,
  about,
}
