final class AuthUserModel {
  final String id;
  final String username;
  final String phoneNumber;
  final String? email;
  final String? image;

  const AuthUserModel({
    this.id = '',
    this.username = '',
    this.phoneNumber = '',
    this.email,
    this.image,
  });

  @override
  String toString() {
    return 'AuthUserEntity{id: $id, username: $username, phoneNumber: $phoneNumber, email: $email, image: $image}';
  }
}
