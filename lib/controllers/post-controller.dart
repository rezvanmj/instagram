import 'package:get/get.dart';
import 'package:instagram/controllers/user-post-controller.dart';
import 'package:instagram/models/post-model.dart';
import 'package:instagram/server/server-url.dart';

class PostController extends GetxController {
  RxList<PostModel> posts = <PostModel>[].obs;
  List<PostModel> postsList = [];
  RxBool loading = false.obs;
  RxBool favorite = false.obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => UserPostController());
    getPostData();
  }

  Future<void> getPostData() async {
    loading(true);
    await ServerUrl.dio.get('/posts').then((value) {
      if (value.statusCode == 200) {
        List<dynamic> dynamicList = value.data;
        postsList = dynamicList.map((e) => PostModel.fromJson(e)).toList();
        posts(postsList);
      } else {
        throw Exception("no connection");
      }
    });
    loading(false);
  }

  Future<void> editPost(PostModel post) async {
    await ServerUrl.dio
        .put('/posts/${post.id}', data: post.toJson())
        .then((value) => getPostData());
  }

  Future<void> addPost(PostModel post) async {
    PostModel userPost;
    loading(true);
    await ServerUrl.dio.post('/posts', data: post).then((value) {
      if (value.statusCode == 200) {
        // print('hello world');
        //   posts.add(PostModel.fromJson(value.data));
        userPost = PostModel.fromJson(value.data);
      }
    }).catchError((e) => throw ('error $e'));
    posts.add(post);
    _userPostController().loggedInUserPosts.add(userPost);
    loading(false);
  }

  Future<void> deletePost(PostModel post) async {
    await ServerUrl.dio
        .delete('/posts/${post.id}', data: post.toJson())
        .then((value) {
      print(value.data);
    });
    posts.removeWhere((element) => element.id == post.id);
  }

  UserPostController _userPostController() {
    return Get.find<UserPostController>();
  }
}
