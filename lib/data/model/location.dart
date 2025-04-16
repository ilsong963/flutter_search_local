class Location {
  String lastBuildDate;
  int total;
  int start;
  int display;
  List<Item> items;

  Location({required this.lastBuildDate, required this.total, required this.start, required this.display, required this.items});
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
}
