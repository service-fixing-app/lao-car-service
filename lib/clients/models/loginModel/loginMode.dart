class UserData {
  final bool status;
  final String message;
  final Customer customer;
  final String token;

  UserData({
    required this.status,
    required this.message,
    required this.customer,
    required this.token,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      status: json['status'],
      message: json['message'],
      customer: Customer.fromJson(json['customer']),
      token: json['token'],
    );
  }
}

class Customer {
  final String firstName;
  final String lastName;
  final int tel;
  final String password;
  final int age;
  final String gender;
  final String birthdate;
  final String village;
  final String district;
  final String province;
  final String profileImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Customer({
    required this.firstName,
    required this.lastName,
    required this.tel,
    required this.password,
    required this.age,
    required this.gender,
    required this.birthdate,
    required this.village,
    required this.district,
    required this.province,
    required this.profileImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      firstName: json['first_name'],
      lastName: json['last_name'],
      tel: json['tel'],
      password: json['password'],
      age: json['age'],
      gender: json['gender'],
      birthdate: json['birthdate'],
      village: json['village'],
      district: json['district'],
      province: json['province'],
      profileImage: json['profile_image'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
