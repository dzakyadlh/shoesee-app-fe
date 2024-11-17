import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/screen_provider.dart';
import 'package:e_commerce_app/providers/wishlist_provider.dart';
import 'package:e_commerce_app/screens/main/chat_screen.dart';
import 'package:e_commerce_app/screens/main/home_screen.dart';
import 'package:e_commerce_app/screens/main/profile_screen.dart';
import 'package:e_commerce_app/screens/main/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AuthProvider authProvider = Provider.of(context, listen: false);
      CartProvider cartProvider = Provider.of(context, listen: false);
      WishlistProvider wishlistProvider = Provider.of(context, listen: false);
      final token = authProvider.user.token!;
      await cartProvider.getCartProducts(token);
      await wishlistProvider.getWishlists(token);
    });
  }

  final List _pages = [
    const HomeScreen(),
    const ChatScreen(),
    const WishlistScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    ScreenProvider screenProvider = Provider.of(context);

    Widget cartButton() {
      return FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/cart');
        },
        backgroundColor: primaryColor,
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
          color: backgroundSecondaryColor,
          notchMargin: 10,
          clipBehavior: Clip.antiAlias,
          child: Wrap(children: [
            BottomNavigationBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                currentIndex: screenProvider.currentIndex,
                onTap: (value) {
                  screenProvider.currentIndex = value;
                },
                items: [
                  BottomNavigationBarItem(
                      label: 'Home',
                      icon: Container(
                        margin: const EdgeInsets.only(top: 8),
                        child: Icon(
                          Icons.home,
                          size: 24,
                          color: screenProvider.currentIndex == 0
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
                          color: screenProvider.currentIndex == 1
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
                          color: screenProvider.currentIndex == 2
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
                          color: screenProvider.currentIndex == 3
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
      backgroundColor: backgroundSecondaryColor,
      resizeToAvoidBottomInset: false,
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: SafeArea(child: _pages[screenProvider.currentIndex]),
    );
  }
}
