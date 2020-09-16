class HomeDetail {
  // ignore: unused_field
  String id;
  // ignore: non_constant_identifier_names
  String HDDesc;
  // ignore: non_constant_identifier_names
  double HDAmount;

  HomeDetail(
      {this.id,
      // ignore: non_constant_identifier_names
      this.HDDesc,
      // ignore: non_constant_identifier_names
      this.HDAmount});

  factory HomeDetail.fromJson(Map<String, dynamic> parsedJson) {
    return HomeDetail(
        id: parsedJson['id'],
        HDDesc: parsedJson['HDDesc'],
        HDAmount: parsedJson['HDAmount']);
  }
}