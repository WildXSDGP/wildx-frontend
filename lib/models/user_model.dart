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

// Factory constructors to create user instances based on the login method
factory UserModel.fromPhone(String phone) => UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        phoneNumber: phone,
        authType: AuthType.phone,
      );

  factory UserModel.fromEmail(String email) => UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        email: email,
        authType: AuthType.email,
      );

  factory UserModel.fromBiometrics() => UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        authType: AuthType.biometric,
      );

  @override
  String toString() =>
      'UserModel(id: $id, phone: $phoneNumber, email: $email, authType: $authType)';
}
