class Welcome {
  String lastBuildDate;
  int total;
  int start;
  int display;
  List<Item> items;

  Welcome({required this.lastBuildDate, required this.total, required this.start, required this.display, required this.items});

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    lastBuildDate: json["lastBuildDate"],
    total: json["total"],
    start: json["start"],
    display: json["display"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "lastBuildDate": lastBuildDate,
    "total": total,
    "start": start,
    "display": display,
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
  };
}

class Item {
  String title;
  String link;
  String category;
  String description;
  String telephone;
  String address;
  String roadAddress;
  String mapx;
  String mapy;

  Item({
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
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
