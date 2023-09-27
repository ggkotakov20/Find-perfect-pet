class User_Pet {
  int id;
  int user_id;
  String name;
  String species;
  String sex;
  String breed;
  String birthdate;
  String weight;
  String food;
  String image;

  User_Pet(
    this.id,
    this.user_id,
    this.name,
    this.species,
    this.sex,
    this.breed,
    this.birthdate,
    this.weight,
    this.food,
    this.image,
  );

  factory User_Pet.fromJson(Map<String, dynamic> json) => User_Pet(
      int.parse(json['id']),
      int.parse(json['user_id']),
      json['name'] ?? '', // Use '' for name if it's null
      json['species'] ?? '', // Use '' for species if it's null
      json['sex'] ?? '', // Use '' for sex if it's null
      json['breed'] ?? '', // Use '' for breed if it's null
      json['birthdate'] ?? '', // Use '' for birthdate if it's null
      json['weight'] ?? '', // Use null for weight if it's null
      json['food'] ?? '', // Use '' for food if it's null
      json['image'] ?? '', // Use '' for image if it's null
  );

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'user_id': user_id.toString(),
        'name': name,
        'species': species,
        'sex': sex,
        'breed': breed,
        'birthdate': birthdate,
        'weight': weight,
        'food': food,
        'image': image,
      };
}
