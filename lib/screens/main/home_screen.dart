import 'package:e_commerce_app/components/product_card.dart';
import 'package:e_commerce_app/components/product_tile.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/models/user_model.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> products = productProvider.products;

    Widget header() {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hello, ${user.name}!',
                    style: primaryTextStyle.copyWith(
                        fontSize: 24, fontWeight: semibold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '@${user.username}',
                    style: subtitleTextStyle.copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                  color: secondaryColor,
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(user.photoUrl.toString()))),
            )
          ],
        ),
      );
    }

    Widget categorySlider() {
      int currentCategory = 0;

      final List<String> categories = [
        'All Shoes',
        'Running',
        'Training',
        'Basketball',
        'Hiking',
        'Casual'
      ];

      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: SizedBox(
          height: 40,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentCategory = index;
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: subtitleTextColor),
                      borderRadius: BorderRadius.circular(12),
                      color: currentCategory == index
                          ? primaryColor
                          : Colors.transparent),
                  child: Text(
                    categories[index],
                    style: (currentCategory == index
                            ? primaryTextStyle
                            : subtitleTextStyle)
                        .copyWith(fontSize: 13, fontWeight: medium),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    Widget popularProducts() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Popular Products',
            style:
                primaryTextStyle.copyWith(fontSize: 22, fontWeight: semibold),
          ),
          const SizedBox(
            height: 14,
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return GestureDetector(
                      child: ProductCard(product: products[index]));
                }),
          )
        ]),
      );
    }

    Widget newArrivals() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('New Arrivals',
                style: primaryTextStyle.copyWith(
                    fontSize: 22, fontWeight: semibold)),
            const SizedBox(
              height: 14,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (_, index) {
                  return GestureDetector(
                      child: ProductTile(product: products[index]));
                })
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              categorySlider(),
              popularProducts(),
              newArrivals()
            ],
          ),
        ),
      ),
    );
  }
}
