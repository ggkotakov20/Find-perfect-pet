import 'package:app/model/user.dart';
import 'package:app/model/user_preferences.dart';
import 'package:get/get.dart';

class CurrentUser extends GetxController{
  Rx<User> _currentUser = User(0, '', '', '', '', '').obs;
  User get user => _currentUser.value;
  getUserInfo() async {
    User? getUserInfoFromLocalStorage = await RememberUserPrefs.readUserData();
    _currentUser.value = getUserInfoFromLocalStorage!;
  }
}