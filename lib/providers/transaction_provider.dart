import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/services/transaction_service.dart';
import 'package:flutter/material.dart';

class TransactionProvider with ChangeNotifier {
  Future<bool> checkout(
    String token,
    List<CartModel> cart,
    String address,
    double totalPrice,
    double shippingPrice,
  ) async {
    try {
      if (await TransactionService()
          .checkout(token, cart, address, totalPrice, shippingPrice)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
