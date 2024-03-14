class UserModel {
  final String username;
  final String email;
  final String password;
  final String phoneNumber;
  final String street;
  final String city;

  UserModel(
      {required this.username,
      required this.email,
      required this.street,
      required this.city,
      required this.password,
      required this.phoneNumber});
}
