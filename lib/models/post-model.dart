class PostModel {
  final int id;
  final String imageUrl;
  final String caption;
  final int ownerId;
  final List<int> commentsId;
  final List<int> likersId;

  PostModel(
      {this.id,
      this.imageUrl,
      this.caption,
      this.ownerId,
      this.commentsId,
      this.likersId});

  factory PostModel.fromJson(Map<String, dynamic> data) {
    return PostModel(
        id: data['id'],
        imageUrl: data['imageUrl'],
        caption: data['caption'],
        ownerId: data['ownerId'],
        commentsId: (data['commentsId'].cast<int>()),
        likersId: (data['likersId'].cast<int>()));
  }
  @override
  String toString() {
    return '{id:$id,caption:$caption,imageUrl:$imageUrl}';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'caption': caption,
      'ownerId': ownerId,
      'commentsId': commentsId.toList(),
      'likersId': likersId.toList(),
    };
  }
}
