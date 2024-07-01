class Student {
  final String id;
  final String name;
  final String dept;
  final String batch;
  final String email;

  Student(
      {required this.id,
      required this.name,
      required this.dept,
      required this.batch,
      required this.email});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dept': dept,
      'batch': batch,
      'email': email,
    };
  }

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      dept: json['dept'],
      batch: json['batch'],
      email: json['email'],
    );
  }
}
