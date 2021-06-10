import 'package:get/get.dart';
import 'package:instagram/controllers/post-controller.dart';
import 'package:instagram/models/comment-model.dart';
import 'package:instagram/models/post-model.dart';
import 'package:instagram/models/user-model.dart';
import 'package:instagram/server/server-url.dart';

class CommentController extends GetxController {
  RxList<CommentModel> comments = <CommentModel>[].obs;
  List<CommentModel> commentsList = [];
  RxBool loading = false.obs;
  Rx<UserModel> commentOwner = UserModel().obs;
  List<int> commentsID;
  CommentController(this.commentsID);
  RxList<UserModel> users = <UserModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    Get.lazyPut(() => PostController());
    print(commentsID);
    await getPostComments(commentsID);
    // await getCommentOwners(commentsID);
  }

  Future<void> getPostComments(List<int> commentsId) async {
    loading(true);
    commentsId.forEach((commentId) async {
      await ServerUrl.dio.get('/comments/$commentId').then((value) async {
        if (value.statusCode == 200) {
          comments.add(CommentModel.fromJson(value.data));
          print('jjjjjj');
          await getCommentOwners(CommentModel.fromJson(value.data));
        }
      }).catchError((e) => throw ('error $e'));
    });
    // getCommentOwners(comments());
    loading(false);
  }

  Future<void> getCommentOwners(CommentModel comment) async {
    await ServerUrl.dio.get('/user/${comment.ownerId}').then((value) {
      users.add(UserModel.fromJson(value.data as Map<String, dynamic>));
    }).catchError((e) => throw ('error $e'));
    print('kkkkkkkkkkkkkkkkkkkkk${users}');
  }

  Future<void> findCommentOwner(int userId) async {
    UserModel owner;
    await ServerUrl.dio.get('/users/$userId').then((value) {
      if (value.statusCode == 200) {
        print(value.data.runtimeType);
        owner = (UserModel.fromJson(value.data as Map<String, dynamic>));
        print('owner is ${owner.id}');
        commentOwner(owner);
      }
    }).catchError((e) => {throw ('error $e')});

    // return commentOwner().username;
    // commentOwner.value = owner;
    // commentOwner.refresh();
  }

  Future<void> addComment(
      CommentModel newComment, PostModel currentPost) async {
    loading(true);
    await ServerUrl.dio
        .post('/comments', data: newComment.toJson())
        .then((value) {
      var commentId = CommentModel.fromJson(value.data).id;
      print(commentId);

      currentPost.commentsId.add(commentId);
      print('current Post is $currentPost');
      _postController.editPost(currentPost);
    }).catchError((e) => throw ('error $e'));
    comments.add(newComment);
    loading(false);
  }

  PostController get _postController {
    return Get.find<PostController>();
  }
}
