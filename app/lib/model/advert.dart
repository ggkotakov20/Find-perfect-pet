class Advert{
  int id;
  int user_id;
  String title;
  String category;
  String price;
  String description;

  Advert(this.id, this.user_id, this.title, this.category,this.price,this.description);

  factory Advert.fromJson(Map<String, dynamic> json) => Advert(
    int.parse(json['id']),
    int.parse(json['user_id']),
    json['title'],
    json['category'],
    json['price'],
    json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id.toString(),
    'user_id': user_id.toString(),
    'title': title,
    'category': category,
    'price': price,
    'description': description,
  };
}