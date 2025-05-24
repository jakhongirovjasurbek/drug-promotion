final class AuthUserModel {
  final String id;
  final String username;
  final String phoneNumber;
  final String? email;
  final String? image;
  final String? firstName;
  final String? familyName;
  final String? middleName;
  final String? fullName;

  const AuthUserModel({
    this.id = '',
    this.username = '',
    this.phoneNumber = '',
    this.email,
    this.image,
    this.familyName,
    this.firstName,
    this.fullName,
    this.middleName,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
        username: json['full_name'],
        phoneNumber: json['mobile_phone'],
        email: json['email'],
        familyName: json['family_name'],
        firstName: json['first_name'],
        image: json['image'],
        fullName: json['full_name'],
        middleName: json['middle_name']);
  }

  @override
  String toString() {
    return 'AuthUserEntity{id: $id, username: $username, phoneNumber: $phoneNumber, email: $email, image: $image}';
  }
}
