/// Model to hold registration form data across multiple pages
class RegistrationFormData {
  // Page 1 - Personal Information
  String? username;
  String? firstName;
  String? middleName;
  String? lastName;

  // Page 2 - Contact & Credentials
  String? email;
  String? parentPhone;
  String? phone;
  String? password1;
  String? password2;
  String? gradeId;
  String? regionId;

  RegistrationFormData({
    this.username,
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.parentPhone,
    this.phone,
    this.password1,
    this.password2,
    this.gradeId,
    this.regionId,
  });

  /// Check if page 1 (personal info) is complete
  bool isPage1Complete() {
    return username != null &&
        username!.isNotEmpty &&
        firstName != null &&
        firstName!.isNotEmpty &&
        middleName != null &&
        middleName!.isNotEmpty &&
        lastName != null &&
        lastName!.isNotEmpty;
  }

  /// Check if page 2 (contact & credentials) is complete
  bool isPage2Complete() {
    return email != null &&
        email!.isNotEmpty &&
        parentPhone != null &&
        parentPhone!.isNotEmpty &&
        password1 != null &&
        password1!.isNotEmpty &&
        password2 != null &&
        password2!.isNotEmpty &&
        gradeId != null &&
        regionId != null;
  }

  /// Check if all required data is complete
  bool isComplete() {
    return isPage1Complete() && isPage2Complete();
  }

  /// Copy with method for immutability
  RegistrationFormData copyWith({
    String? username,
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,
    String? parentPhone,
    String? phone,
    String? password1,
    String? password2,
    String? gradeId,
    String? regionId,
  }) {
    return RegistrationFormData(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      parentPhone: parentPhone ?? this.parentPhone,
      phone: phone ?? this.phone,
      password1: password1 ?? this.password1,
      password2: password2 ?? this.password2,
      gradeId: gradeId ?? this.gradeId,
      regionId: regionId ?? this.regionId,
    );
  }
}
