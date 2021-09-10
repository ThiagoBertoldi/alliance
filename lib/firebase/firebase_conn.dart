import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase_Conn {
  Firebase_Conn._();
  static final Firebase_Conn _instance = Firebase_Conn._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static FirebaseFirestore get() {
    return Firebase_Conn._instance._firestore;
  }
}
