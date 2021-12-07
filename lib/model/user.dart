class UserFields {
  static final String id = 'Stt';
  static final String name = 'Họ và Tên';
  static final String email = 'email';
  static final String degree = 'Khóa';
  static final String phone = 'Số điện thoại';
  static final String fb = 'Link Facebook';
  static final String date = 'Date';



  static List<String> getFields() => [id, name, email, degree, phone, fb, date];
}

class User {
  final int? id;
  final String name;
  final String email;
  final String degree;
  final String phone;
  final String fb;
  final String date;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.degree,
    required this.phone,
    required this.fb,
    required this.date,
  });

  User copy({
    int? id,
    String? name,
    String? email,
    String? degree,
    String? phone,
    String? fb,
    String? date,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        degree: degree ?? this.degree,
        phone: phone ?? this.phone,
        fb: fb ?? this.fb,
        date: fb ?? this.date,
      );

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.email: email,
        UserFields.degree: degree,
        UserFields.phone: phone,
        UserFields.fb: fb,
        UserFields.date: date,
      };
}
