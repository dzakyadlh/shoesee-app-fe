import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/providers/auth_provider.dart';
import 'package:e_commerce_app/providers/cart_provider.dart';
import 'package:e_commerce_app/providers/wishlist_provider.dart';
import 'package:e_commerce_app/screens/chat_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key, required this.product});

  final ProductModel product;

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  int currentIndex = 0;

  List similarShoes = [
    'assets/images/shoe_1.png',
    'assets/images/shoe_1.png',
    'assets/images/shoe_1.png',
    'assets/images/shoe_1.png',
    'assets/images/shoe_1.png',
    'assets/images/shoe_1.png',
    'assets/images/shoe_1.png',
    'assets/images/shoe_1.png',
  ];

  @override
  Widget build(BuildContext context) {
    bool isWishlisted = ref
        .read(wishlistNotifierProvider.notifier)
        .isWishlisted(widget.product);

    Future<void> showSuccessDialog() async {
      return showDialog(
          context: context,
          builder: (BuildContext context) => SizedBox(
                width: MediaQuery.of(context).size.width - (2 * defaultMargin),
                child: AlertDialog(
                  backgroundColor: backgroundTertiaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: primaryTextColor,
                              size: 24,
                            ),
                          ),
                        ),
                        Image.asset(
                          'assets/images/icon_success.png',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Yay!',
                          style: primaryTextStyle.copyWith(
                              fontSize: 18, fontWeight: semibold),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          'Item added to your cart',
                          style: secondaryTextStyle.copyWith(fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 10),
                          child: FilledButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/cart');
                              },
                              style: FilledButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12))),
                              child: Text(
                                'View my Cart',
                                style: primaryTextStyle.copyWith(
                                    fontSize: 16, fontWeight: medium),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
    }

    PreferredSizeWidget topBar() {
      return PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.chevron_left,
                  color: backgroundPrimaryColor,
                  size: 24,
                )),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                  icon: Icon(
                    Icons.shopping_cart,
                    color: backgroundPrimaryColor,
                    size: 24,
                  ))
            ],
          ));
    }

    Widget indicator(int index) {
      return Container(
        width: currentIndex == index ? 16 : 4,
        height: 4,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color:
                currentIndex == index ? primaryColor : const Color(0xFFC4C4C4)),
      );
    }

    Widget header() {
      return Column(
        children: [
          CarouselSlider(
              items: widget.product.gallery
                  .map((img) => Image.network(
                        img.url,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                  initialPage: 0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                  enableInfiniteScroll: false,
                  height: 310)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.product.gallery.asMap().entries.map((entry) {
              return indicator(entry.key);
            }).toList(),
          )
        ],
      );
    }

    Widget similarShoesCard(String imageUrl) {
      return GestureDetector(
          onTap: () {},
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            width: 54,
            height: 54,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(image: AssetImage(imageUrl))),
          ));
    }

    Widget contents() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(defaultMargin),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          color: backgroundPrimaryColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      style: primaryTextStyle.copyWith(
                          fontSize: 18, fontWeight: semibold),
                    ),
                    Text(
                      widget.product.category.name,
                      style: subtitleTextStyle.copyWith(fontSize: 12),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    ref
                        .read(wishlistNotifierProvider.notifier)
                        .setProduct(widget.product);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        isWishlisted
                            ? 'This item has been removed to your wishlist'
                            : 'This item has been added from your wishlist',
                        textAlign: TextAlign.center,
                        style: primaryTextStyle.copyWith(fontSize: 12),
                      ),
                      backgroundColor: isWishlisted ? alertColor : primaryColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(6))),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      duration: const Duration(seconds: 3),
                    ));
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: isWishlisted
                        ? onSecondaryColor
                        : backgroundPrimaryColor,
                    size: 20,
                  ),
                  style: IconButton.styleFrom(
                      backgroundColor:
                          isWishlisted ? primaryColor : const Color(0xFF423F53),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            // Price
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: backgroundSecondaryColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Price starts from',
                    style: primaryTextStyle.copyWith(fontSize: 14),
                  ),
                  Text(
                    '\$${widget.product.price}',
                    style: priceTextStyle.copyWith(
                        fontSize: 16, fontWeight: semibold),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            // Description
            Text(
              'Description',
              style:
                  primaryTextStyle.copyWith(fontSize: 14, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              widget.product.description,
              style:
                  subtitleTextStyle.copyWith(fontSize: 14, fontWeight: light),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(
              height: 30,
            ),

            // Recomendations
            Text(
              'Similar Shoes',
              style:
                  primaryTextStyle.copyWith(fontSize: 14, fontWeight: medium),
            ),
            const SizedBox(
              height: 12,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: similarShoes.asMap().entries.map((entry) {
                  return similarShoesCard(entry.value);
                }).toList(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            // Buttons
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ChatDetailScreen(product: widget.product)));
                  },
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                        border: Border.all(color: primaryColor),
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.chat,
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: SizedBox(
                    height: 54,
                    child: FilledButton(
                        onPressed: () {
                          ref
                              .read(cartNotifierProvider.notifier)
                              .updateCartProduct(
                                  ref.watch(authNotifierProvider).value!.token!,
                                  widget.product.id,
                                  1);
                          showSuccessDialog();
                        },
                        style: FilledButton.styleFrom(
                            backgroundColor: primaryColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        child: Text(
                          'Add to Cart',
                          style: primaryTextStyle.copyWith(
                              fontSize: 16, fontWeight: semibold),
                        )),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: topBar(),
      backgroundColor: const Color.fromARGB(255, 236, 237, 239),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.zero,
          child: Column(
            children: [header(), contents()],
          ),
        ),
      ),
    );
  }
}
