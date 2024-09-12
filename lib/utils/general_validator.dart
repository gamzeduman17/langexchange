import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> checkIfValueExists({
  required String collection,
  required String field,
  required String value,
}) async {
  try {
    final snapshot = await FirebaseFirestore.instance.collection(collection)
        .where(field, isEqualTo: value)
        .get();
    return snapshot.docs.isNotEmpty;
  }
  catch(e){
    print("Error checking value existence: $e");
    return false;
  }
}