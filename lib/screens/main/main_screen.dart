import 'package:e_commerce_app/screens/main/chat_screen.dart';
import 'package:e_commerce_app/screens/main/home_screen.dart';
import 'package:e_commerce_app/screens/main/profile_screen.dart';
import 'package:e_commerce_app/screens/main/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final List _pages = [
    const HomeScreen(),
    const ChatScreen(),
    const WishlistScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    Widget cartButton() {
      return FloatingActionButton(
        onPressed: () {},
        backgroundColor: secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Icons.shopping_cart,
          size: 24,
          color: onSecondaryColor,
        ),
      );
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: backgroundFourthColor,
          notchMargin: 10,
          clipBehavior: Clip.antiAlias,
          child: Wrap(children: [
            BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: currentIndex,
                onTap: (value) {
                  setState(() {
                    currentIndex = value;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                      label: 'Home',
                      icon: Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Icon(
                          Icons.home,
                          size: 24,
                          color: currentIndex == 0
                              ? primaryColor
                              : const Color(0xFF808191),
                        ),
                      )),
                  BottomNavigationBarItem(
                      label: 'Chat',
                      icon: Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Icon(
                          Icons.chat,
                          size: 24,
                          color: currentIndex == 1
                              ? primaryColor
                              : const Color(0xFF808191),
                        ),
                      )),
                  BottomNavigationBarItem(
                      label: 'Wishlist',
                      icon: Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Icon(
                          Icons.favorite,
                          size: 24,
                          color: currentIndex == 2
                              ? primaryColor
                              : const Color(0xFF808191),
                        ),
                      )),
                  BottomNavigationBarItem(
                      label: 'Profile',
                      icon: Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Icon(
                          Icons.person,
                          size: 24,
                          color: currentIndex == 3
                              ? primaryColor
                              : const Color(0xFF808191),
                        ),
                      )),
                ]),
          ]),
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      resizeToAvoidBottomInset: false,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: SafeArea(child: _pages[currentIndex]),
    );
  }
}
