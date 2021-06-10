
class CommentModel{

  final int id;
  final String comment;
  final int ownerId;

  CommentModel({this.id, this.comment, this.ownerId});

  Map<String , dynamic> toJson(){
   return{
    'id' : id,
    'comment' : comment ,
    'ownerId' : ownerId
   };
  }

  factory CommentModel.fromJson(Map <String , dynamic> data){
   return CommentModel(
     id: data['id'],
     comment: data['comment'],
     ownerId: data['ownerId'],
   );
  }

}