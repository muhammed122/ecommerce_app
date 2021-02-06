class UserModel {

  String userId;
  String userName;
  String userEmail;
  String userPhone;

  UserModel({this.userId, this.userName, this.userEmail, this.userPhone});

  Map<String, dynamic> toJson() =>
      {
        'userName': userName,
        'userEmail': userEmail,
        'userPhone': userPhone,
      };


}
