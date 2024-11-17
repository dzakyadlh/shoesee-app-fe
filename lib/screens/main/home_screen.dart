import 'package:e_commerce_app/components/loading_screen.dart';
import 'package:e_commerce_app/components/product_card.dart';
import 'package:e_commerce_app/components/product_tile.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedCategory = 0;

  @override
  void initState() {
    super.initState();
    ref.read(productNotifierProvider.notifier).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authNotifierProvider);
    final products = ref.watch(productNotifierProvider);

    Widget header() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
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
                    'Hello, ${user.value?.name}!',
                    style: primaryTextStyle.copyWith(
                        fontSize: 24, fontWeight: semibold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '@${user.value?.username}',
                    style: subtitleTextStyle.copyWith(fontSize: 16),
                  )
                ],
              ),
            ),
            Container(
              width: 54,
              height: 54,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/profile_pic_default.png'))),
            )
          ],
        ),
      );
    }

    Widget categorySlider() {
      final List<String> categories = [
        'All Shoes',
        'Sport',
        'Hiking',
        'Basketball',
        'Training',
        'Running',
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
                    _selectedCategory = index;
                  });
                  if (_selectedCategory == 0) {
                    ref.read(productNotifierProvider.notifier).clearFilter();
                  } else {
                    ref
                        .read(productNotifierProvider.notifier)
                        .filterProductsByCategory(_selectedCategory);
                  }
                },
                child: Container(
                  margin: index == 0
                      ? EdgeInsets.only(left: defaultMargin)
                      : const EdgeInsets.only(left: 16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: secondaryTextColor),
                    borderRadius: BorderRadius.circular(12),
                    color: _selectedCategory == index
                        ? primaryColor
                        : Colors.transparent,
                  ),
                  child: Text(
                    categories[index],
                    style: (_selectedCategory == index
                            ? primaryTextStyle
                            : subtitleTextStyle)
                        .copyWith(
                      fontSize: 13,
                      fontWeight: semibold,
                    ),
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
          Padding(
            padding: EdgeInsets.only(left: defaultMargin),
            child: Text(
              'Popular Products',
              style:
                  primaryTextStyle.copyWith(fontSize: 22, fontWeight: semibold),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          SizedBox(
            height: 280,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: products.value?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return Container(
                      margin: index == 0
                          ? EdgeInsets.only(left: defaultMargin)
                          : const EdgeInsets.only(left: 16),
                      child: ProductCard(product: products.value![index]));
                }),
          )
        ]),
      );
    }

    Widget newArrivals() {
      return Container(
        margin: EdgeInsets.only(
            top: defaultMargin, left: defaultMargin, right: defaultMargin),
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
                itemCount: products.value?.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (_, index) {
                  return GestureDetector(
                      child: ProductTile(product: products.value![index]));
                })
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: backgroundPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: products.when(
          data: (products) {
            if (products.isEmpty) {
              return const Center(
                  child: Text('No popular products available.'));
            }
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header(),
                  categorySlider(),
                  popularProducts(),
                  newArrivals(),
                ],
              ),
            );
          },
          loading: () => const LoadingScreen(),
          error: (error, stackTrace) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }
}
