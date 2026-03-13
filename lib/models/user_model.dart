enum AuthType { phone, email, biometric }

// This is the model for WildX user data
class UserModel {
  final String id;
  final String? phoneNumber;
  final String? email;
  final AuthType authType;


  const UserModel({
    required this.id,
    this.phoneNumber,
    this.email,
    required this.authType,
  });
}