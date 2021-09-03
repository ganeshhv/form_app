class UserModel {
  String uid;
  String email;
  String name;
  String phoneNumber;
  String password;
  String address;
  String fssai;

  UserModel(
      {
        required this.uid,
        required this.email,
        required this.name,
        required this.phoneNumber,
        required this.password,
        required this.address,
        required this.fssai
      });

}