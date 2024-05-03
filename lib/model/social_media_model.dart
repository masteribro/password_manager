// To parse this JSON data, do
//
//     final socialMediaAccount = socialMediaAccountFromJson(jsonString);

import 'dart:convert';

SocialMediaAccount socialMediaAccountFromJson(String str) => SocialMediaAccount.fromJson(json.decode(str));

String socialMediaAccountToJson(SocialMediaAccount data) => json.encode(data.toJson());

class SocialMediaAccount {
  String? name;
  String? logoSvgPath;
  String? password;
  String? email;

  SocialMediaAccount({
    this.name,
    this.logoSvgPath,
    this.password,
    this.email,
  });

  factory SocialMediaAccount.fromJson(Map<String, dynamic> json) => SocialMediaAccount(
    name: json[" name"],
    logoSvgPath: json["logoSvgPath"],
    password: json["password"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    " name": name,
    "logoSvgPath": logoSvgPath,
    "password": password,
    "email": email,
  };
}
