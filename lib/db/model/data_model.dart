class StudentModel {
  int? id;

  final String name;

  final String age;

  final String place;

  final String phone;

  final String image;

  StudentModel(
      {required this.name,
      required this.age,
      required this.place,
      required this.phone,
      required this.image,
      this.id});
  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'] as String;
    final age = map['age'] as String;
    final place = map['place'] as String;
    final phone = map['phone'] as String;
    final image = map['image'] as String;
    return StudentModel(
      id: id,
      name: name,
      age: age,
      place: place,
      phone: phone,
      image: image,
    );
  }
}
