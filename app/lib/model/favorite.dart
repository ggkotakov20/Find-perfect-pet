class Favorite{
  int user_id;
  int advert_id;
  String action;

  Favorite(this.user_id, this.advert_id, this.action,);

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    int.parse(json['user_id']),
    int.parse(json['advert_id']),
    json['action']
  );

  Map<String, dynamic> toJson() => {
    'user_id': user_id.toString(),
    'advert_id': advert_id.toString(),
    'action': action
  };
}