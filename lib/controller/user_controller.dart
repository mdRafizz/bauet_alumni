import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/model/user_model.dart';

class UserController extends GetxController {
  var user = Rxn<UserModel>();
  var isLoading = true.obs;

  var users = <UserModel>[].obs;
  var isLoading2 = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllUsers();
  }

  Future<void> fetchAllUsers() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').get();
      users.value = querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Error fetching users: $e');
    } finally {
      isLoading2.value = false;
    }
  }

// @override
// void onInit() {
//   super.onInit();
//   fetchUserData();
// }

// Future<void> fetchUserData() async {
//   try {
//     User? currentUser = FirebaseAuth.instance.currentUser;
//     if (currentUser != null) {
//       String email = currentUser.email!;
//       DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(email).get();
//       if (doc.exists) {
//         user.value = UserModel.fromJson(doc.data() as Map<String, dynamic>);
//       }
//     }
//   } catch (e) {
//     print('Error fetching user data: $e');
//   } finally {
//     isLoading.value = false;
//   }
// }
}
