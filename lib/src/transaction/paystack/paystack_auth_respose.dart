// class PaystackAuthRespose {
//   final String authorization_url;
//   final String access_code;
//   final String reference;
//   final String email;

//   PaystackAuthRespose(
//       {required this.authorization_url,
//       required this.access_code,
//       required this.reference,
//       required this.email});

//   factory PaystackAuthRespose.fromJson(Map<String, dynamic> json) {
//     return PaystackAuthRespose(
//         authorization_url: json['authorization_url'],
//         access_code: json['access_code'],
//         email: json['email'],
//         reference: json['reference']);
//   }
//   Map<String, dynamic> toJson() {
//     return {
//       'authorization_url': authorization_url,
//       'access_code': access_code,
//       'reference': reference,
//       'email': email
//     };
//   }
// }

class PaystackAuthRespose {
  final String authorization_url;

  PaystackAuthRespose({required this.authorization_url});

  factory PaystackAuthRespose.fromJson(Map<String, dynamic> json) {
    return PaystackAuthRespose(
      authorization_url: json['authorization_url'],
    );
  }
}
