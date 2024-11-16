import 'package:e_commerce_app/models/cart_model.dart';
import 'package:e_commerce_app/services/transaction_service.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'transaction_provider.g.dart';

// Enum to define the different transaction states
enum TransactionState {
  initial,
  loading,
  success,
  error,
}

@riverpod
class TransactionNotifier extends _$TransactionNotifier {
  // Initial state is the initial state.
  @override
  TransactionState build() {
    return TransactionState.initial;
  }

  // Checkout method to perform the transaction and update state accordingly
  Future<bool> checkout(
    String token,
    List<CartProduct> cart,
    String address,
    double totalPrice,
    double shippingPrice,
  ) async {
    state = TransactionState
        .loading; // Set state to loading when the request starts
    try {
      bool success = await TransactionService()
          .checkout(token, cart, address, totalPrice, shippingPrice);
      if (success) {
        state = TransactionState
            .success; // Set state to success if the checkout is successful
        return true;
      } else {
        state =
            TransactionState.error; // Set state to error if the checkout fails
        return false;
      }
    } catch (e) {
      state =
          TransactionState.error; // Set state to error if there is an exception
      debugPrint('Transaction error: $e');
      return false;
    }
  }
}
