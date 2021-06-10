import 'package:get/get.dart';
import 'package:instagram/controllers/user-controller.dart';
import 'package:instagram/models/post-model.dart';
import 'package:instagram/server/server-url.dart';

class UserPostController extends GetxController {
  RxList<PostModel> loggedInUserPosts = <PostModel>[].obs;
  RxBool loading = false.obs;
  int loggedInUserId;
  List<PostModel> postList = [];

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => UserController());
    loggedInUserId = _userController().loggedInUser().id;
    findUserPost(loggedInUserId);
  }

  Future<void> findUserPost(int loggedInUserId) async {
    loading(true);
    await ServerUrl.dio.get('/posts?ownerId=$loggedInUserId').then((value) {
      List<dynamic> dynamicList = value.data;
      postList = dynamicList.map((e) => PostModel.fromJson(e)).toList();
    }).catchError((e) => throw ('error $e'));
    loggedInUserPosts(postList);
    loading(false);
  }

  UserController _userController() {
    return Get.find<UserController>();
  }
}
