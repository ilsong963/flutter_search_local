class Location {
  String title;
  String link;
  String category;
  String description;
  String telephone;
  String address;
  String roadAddress;
  String mapx;
  String mapy;

  Location({
    required this.title,
    required this.link,
    required this.category,
    required this.description,
    required this.telephone,
    required this.address,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    title: json["title"],
    link: json["link"],
    category: json["category"],
    description: json["description"],
    telephone: json["telephone"],
    address: json["address"],
    roadAddress: json["roadAddress"],
    mapx: json["mapx"],
    mapy: json["mapy"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "category": category,
    "description": description,
    "telephone": telephone,
    "address": address,
    "roadAddress": roadAddress,
    "mapx": mapx,
    "mapy": mapy,
  };
}
