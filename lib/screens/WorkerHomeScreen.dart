import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:mic_fuel/src/live_tracking_methods.dart';
import 'package:mic_fuel/screens/login.dart';
import 'package:mic_fuel/screens/worker_home.dart';
import 'package:mic_fuel/themes/colors.dart';

import '../src/profile.dart';

class HomeWorker extends StatefulWidget {
  const HomeWorker({super.key});

  @override
  _HomeWorkerScreenState createState() => _HomeWorkerScreenState();
}

class _HomeWorkerScreenState extends State<HomeWorker> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentPage = DrawerSections.home;
  bool drawerOrNav = false;
  String _username = "User"; // Default name
  final _selectedIndex = ValueNotifier<int>(0);
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
    } else if (currentPage == DrawerSections.offer) {
      container = OfferPage();
    } else if (currentPage == DrawerSections.about) {
      container = AboutPage();
    } else if (currentPage == DrawerSections.settings) {
      container = SettingPage();
    } else if (currentPage == DrawerSections.dashboard) {
      container = DashboardScreen();
    } else if (currentPage == DrawerSections.payment) {
      container = PaymentPage();
    } else if (currentPage == DrawerSections.support) {
      container = SupportPage();
    } else if (currentPage == DrawerSections.referandearn) {
      container = ReferAndEarnPage();
    } else if (currentPage == DrawerSections.wallet) {
      container = WalletPage();
    } else if (currentPage == DrawerSections.logout) {
      container = MyOrders();
    }
    return Scaffold(
      appBar: AppBar(
        // leading: Drawer(),
        backgroundColor: KColors.primaryGrey,
        title: Text(
          'Welcome $_username',
          style: TextStyle(
              color: KColors.primaryBlack,
              fontFamily: 'Poppins',
              fontSize: 22,
              fontWeight: FontWeight.w300),
        ),
        actions: [
          IconButton(
            color: KColors.primaryBlack,
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => NotificationPage()));
            }, // Add your notification functionality here
          ),
        ],
      ),
      body: drawerOrNav
          ? container
          : ValueListenableBuilder<int>(
              valueListenable: _selectedIndex,
              builder: (context, selectedIndex, child) {
                switch (selectedIndex) {
                  case 0:
                    return HomeScreenw(); // Replace with your home page widget
                  case 1:
                    return HistoryPage(); // Replace with your history page widget
                  case 2:
                    return SettingPage();
                  case 3:
                    return ProfilePage(); // Replace with your settings page widget
                  default:
                    return const Center(child: Text('Error: Invalid Index'));
                }
              },
            ),

      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyListDrawer(),
                SizedBox(
                  height: 8.h,
                ),
                TextButton(
                    onPressed: () => {
                          _logOut(),
                        },
                    child: const Text('Log Out'))
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8.0,
            onTabChange: (index) => setState(() {
              _selectedIndex.value = index;
              drawerOrNav = false;
            }),
            padding: EdgeInsets.all(16),
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
                icon: Icons.book_online_outlined,
                text: 'Others',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: Colors.deepPurpleAccent,
      //   child: const Icon(Icons.play_arrow),
      // ),
      //2nd style bottom bar
      // bottomNavigationBar: SlidingClippedNavBar(
      //   backgroundColor: Colors.white,
      //   onButtonPressed: (index) {
      //     setState(() {
      //       selectedIndex = index;
      //     });
      //   },
      //   iconSize: 30,
      //   activeColor: Colors.black,
      //   selectedIndex: selectedIndex,
      //   barItems: [
      //     BarItem(title: 'Home', icon: Icons.home),
      //     BarItem(title: 'History', icon: Icons.history),
      //     BarItem(title: 'Status', icon: Icons.track_changes),
      //     BarItem(title: 'Settings', icon: Icons.settings_outlined),
      //   ],
      // ),
    );
  }

  Widget MyListDrawer() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        //Show the list of the menu DRAWER
        children: [
          menuItem(1, "Home", Icons.home,
              currentPage == DrawerSections.home ? true : false),
          menuItem(2, "Dashboard", Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(3, "Support", Icons.lightbulb,
              currentPage == DrawerSections.support ? true : false),
          menuItem(4, "Wallet", Icons.money_outlined,
              currentPage == DrawerSections.wallet ? true : false),
          menuItem(9, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(5, "Offer", Icons.shopping_bag,
              currentPage == DrawerSections.offer ? true : false),
          menuItem(10, "Refer & Earn", Icons.gif_box_outlined,
              currentPage == DrawerSections.referandearn ? true : false),
          menuItem(6, "Payment", Icons.attach_money_outlined,
              currentPage == DrawerSections.payment ? true : false),
          menuItem(7, "About", Icons.query_stats,
              currentPage == DrawerSections.about ? true : false),
          menuItem(8, "Log Out", Icons.logout,
              currentPage == DrawerSections.logout ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            drawerOrNav = true;
            if (id == 1) {
              currentPage = DrawerSections.home;
            } else if (id == 2) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 3) {
              currentPage = DrawerSections.support;
            } else if (id == 4) {
              currentPage = DrawerSections.wallet;
            } else if (id == 5) {
              currentPage = DrawerSections.offer;
            } else if (id == 6) {
              currentPage = DrawerSections.payment;
            } else if (id == 7) {
              currentPage = DrawerSections.about;
            } else if (id == 8) {
              currentPage = DrawerSections.logout;
            } else if (id == 9) {
              currentPage = DrawerSections.settings;
            } else if (id == 10) {
              currentPage = DrawerSections.referandearn;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.black,
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
    // Clear user information
    clearUserData();
    // Navigate to the login page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LogIn()),
    );
  }

  void clearUserData() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      _username = 'User';
    });
  }
}

enum DrawerSections {
  home,
  dashboard,
  support,
  wallet,
  settings,
  offer,
  logout,
  payment,
  referandearn,
  about,
}
