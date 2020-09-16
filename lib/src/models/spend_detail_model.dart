class SpendDetail {
  // ignore: unused_field
  String id;
  // ignore: non_constant_identifier_names
  String SDDesc;
  // ignore: non_constant_identifier_names
  double SDAmount;

  SpendDetail(
      {this.id,
      // ignore: non_constant_identifier_names
      this.SDDesc,
      // ignore: non_constant_identifier_names
      this.SDAmount});

  factory SpendDetail.fromJson(Map<String, dynamic> parsedJson) {
    return SpendDetail(
        id: parsedJson['id'],
        SDDesc: parsedJson['SDDesc'],
        SDAmount: parsedJson['SDAmount']);
  }
}