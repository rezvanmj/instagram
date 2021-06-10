import 'package:get/get.dart';
import 'package:instagram/controllers/post-controller.dart';
import 'package:instagram/models/user-model.dart';
import 'package:instagram/server/server-url.dart';

class UserController extends GetxController {
  Rx<UserModel> loggedInUser = UserModel().obs;
  RxList<UserModel> users = <UserModel>[].obs;
  List<UserModel> usersList = [];
  RxBool isAuth = false.obs;
  RxBool loading = false.obs;
  RxBool isSameUsername = false.obs;
  RxBool mainPageFlag = true.obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => PostController());
    getUserData();
  }

  Future<void> authenticate(String username, String password) async {
    loading(true);
    await ServerUrl.dio
        .get('/users?username=$username&password=$password')
        .then((value) {
      if (value.statusCode == 200) {
        List<dynamic> dynamicList = value.data;
        print(dynamicList);
        if (dynamicList.isBlank) {
          isAuth(false);
        } else {
          isAuth(true);
          usersList = dynamicList.map((e) => UserModel.fromJson(e)).toList();
          loggedInUser(usersList[0]);
          mainPageFlag(false);
        }
      }
    }).catchError((e) => throw ('error $e'));
    loading(false);
  }

  Future<void> search(String searchQuery) async {
    loading(true);
    await ServerUrl.dio.get('/users?username_like=$searchQuery').then((value) {
      List<dynamic> dynamicList = value.data;
      usersList = dynamicList.map((e) => UserModel.fromJson(e)).toList();
      users(usersList);
    });
    loading(false);
  }

  Future<void> getUserData() async {
    loading(true);
    await ServerUrl.dio.get('/users').then((value) {
      if (value.statusCode == 200) {
        List<dynamic> dynamicList = value.data;
        usersList = dynamicList.map((e) => UserModel.fromJson(e)).toList();
        users(usersList);
      }
    });
    loading(false);
  }

  Future<void> checkUsername(String username) async {
    await ServerUrl.dio.get('/users?username=$username').then((value) {
      if (value.statusCode == 200) {
        List<dynamic> dynamicList = value.data;
        if (dynamicList.isBlank) {
          isSameUsername(false);
        } else {
          isSameUsername(true);
        }
      }
    });
  }

  Future<void> addUser(UserModel user) async {
    await ServerUrl.dio.post('/users', data: user).then((value) {
      loggedInUser(UserModel.fromJson(value.data));
    }).catchError((e) {
      print('error catch $e');
    });
    users.add(user);
  }

  Future<void> editUser(UserModel user) async {
    await ServerUrl.dio.patch('/users/${user.id}', data: user);
    loggedInUser(user);
    getUserData();
  }

  Future<void> deleteUser(UserModel user) async {
    await ServerUrl.dio.delete('/users/${user.id}', data: user);
    users.removeWhere((u) => u.id == user.id);
  }

  PostController _postController() {
    return Get.find<PostController>();
  }
}
