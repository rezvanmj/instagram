class UserModel{

  final int id;
  final String email;
  final String imageUrl;
  final String username;
  final String password;

  UserModel({this.id, this.imageUrl ,this.email, this.username, this.password});

  factory UserModel.fromJson(Map<String , dynamic> data){
   return UserModel(
     id:data['id'],
     imageUrl: data['imageUrl'],
    email:data['email'],
    username: data['username'],
     password:data['password']);
  }

  Map<String , dynamic> toJson(){
   return{
     'id' : id,
     'imageUrl' : imageUrl ,
     'username' : username ,
     'password' : password ,
     'email' :email,
   };
  }

}