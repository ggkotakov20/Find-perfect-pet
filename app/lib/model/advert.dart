class Advert{
  int id;
  int user_id;
  String title;
  String price;
  String description;

  Advert(this.id, this.user_id, this.title,this.price,this.description);

  factory Advert.fromJson(Map<String, dynamic> json) => Advert(
    int.parse(json['id']),
    int.parse(json['user_id']),
    json['title'],
    json['price'],
    json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id.toString(),
    'user_id': user_id.toString(),
    'title': title,
    'price': price,
    'description': description,
  };
}