import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/models/message_model.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/models/user_model.dart';

class MessageService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<MessageModel>> getMessagesByUserId({required int userId}) {
    try {
      return firestore
          .collection('messages')
          .where('userId', isEqualTo: userId)
          .snapshots()
          .map((QuerySnapshot list) {
        var result = list.docs.map<MessageModel>((DocumentSnapshot message) {
          var data = message.data() as Map<String, dynamic>;
          print("Data fetched: $data");
          return MessageModel.fromJson(data);
        }).toList();

        result.sort((MessageModel a, MessageModel b) =>
            a.createdAt.compareTo(b.createdAt));

        return result;
      });
    } catch (e) {
      print("Error in getMessagesByUserId: $e");
      throw Exception(e);
    }
  }

  Future<void> addMessage({
    required UserModel user,
    required bool isFromUser,
    required String message,
    required ProductModel product,
  }) async {
    try {
      firestore.collection('messages').add({
        'userId': user.id,
        'username': user.name,
        'userImageUrl': user.photoUrl,
        'isFromUser': true,
        'message': message,
        'product': product is UninitializedProductModel ? {} : product.toJson(),
        'createdAt': DateTime.now().toString(),
        'updatedAt': DateTime.now().toString(),
      });
    } catch (e) {
      print("Failed to send message: $e");
      throw Exception('Failed to send message');
    }
  }
}
