import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:langexchange/models/user_model.dart';

class UserSevice {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveUserInfo(UserModel user) async {
    try {
      await _db.collection('users').doc(user.username).set(user.toJson());
    } catch (e) {
      print('Error saving user info: $e');
    }
  }

  Future<UserModel?> getUserInfo(String username) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(username).get();
      if (doc.exists) {
        return UserModel.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        return null; //burası hata mesajıyla düzenlenmeli
      }
    } catch (e) {
      print('Error getting user info: $e');
      return null;
    }
  }
}
