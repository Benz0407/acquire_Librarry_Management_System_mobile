class User {
  final int? userId;
  final int? role;
  final String? schoolIdNumber;
  late final String libraryCardNumber;
  final String password;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? suffix;
  final String? department;
  final String? course;
  final String? contactNumber;
  final String? emailAddress;

  User({
    this.userId,
    this.role,
    this.schoolIdNumber,
    required this.libraryCardNumber,
    required this.password,
    this.firstName,
    this.middleName,
    this.lastName,
    this.suffix,
    this.department,
    this.course,
    this.contactNumber,
    this.emailAddress,
  });

  // You can add methods like toJson and fromJson if needed for serialization
  Map<String, dynamic> toJson() => {
        'UserType' : role, 
        'LibraryCardNumber': libraryCardNumber,
        'SchoolId': schoolIdNumber,
        'FirstName': firstName,
        'MiddleName': middleName,
        'LastName': lastName,
        'Suffix': suffix,
        'Department': department,
        'Course': course,
        'ContactNumber': contactNumber,
        'EmailAdd': emailAddress,
        'Password': password
      };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      role: json['UserType'],
      userId: json['UserId'],
      libraryCardNumber: json['LibraryCardNumber'],
      schoolIdNumber: json['SchoolIdNumber'],
      firstName: json['FirstName'],
      middleName: json['MiddleName'],
      lastName: json['LastName'],
      suffix: json['Suffix'],
      department: json['Department'],
      course: json['Course'],
      contactNumber: json['ContactNumber'],
      emailAddress: json['EmailAdd'],
      password: json['Password'],
    );
  }

  Map<String, dynamic> toMap() => {
        'Role': role,
        'UserId': userId,
        'LibraryCardNumber': libraryCardNumber,
        'SchoolId': schoolIdNumber,
        'FirstName': firstName,
        'MiddleName': middleName,
        'LastName': lastName,
        'Suffix': suffix,
        'Department': department,
        'Course': course,
        'ContactNumber': contactNumber,
        'EmailAdd': emailAddress,
        'Password': password
      };
}
