class Advert{
  int id;
  int user_id;
  String title;
  String category;
  String type;
  String price;
  String description;
  String image;

  Advert(this.id, this.user_id, this.title, this.category, this.type, this.price,this.description, this.image);

  factory Advert.fromJson(Map<String, dynamic> json) => Advert(
    int.parse(json['id']),
    int.parse(json['user_id']),
    json['title'],
    json['category'],
    json['type'],
    json['price'],
    json['description'],
    json['image'],
  );

  Map<String, dynamic> toJson() => {
    'id': id.toString(),
    'user_id': user_id.toString(),
    'title': title,
    'category': category,
    'type': type,
    'price': price,
    'description': description,
    'image': image,
  };
}