class Spend {
  // ignore: unused_field
  String id;
  String date; //String date;
  String description;
  double amount;
  // ignore: non_constant_identifier_names
  List<HomeDetail> sd_homeDetail;
  // ignore: non_constant_identifier_names
  List<SpendDetail> sd_spendDetail;

  Spend(
      {this.id,
      this.date,
      this.description,
      this.amount,
      // ignore: non_constant_identifier_names
      this.sd_homeDetail,
      // ignore: non_constant_identifier_names
      this.sd_spendDetail});

  factory Spend.fromJson(Map<String, dynamic> parsedJson) {
    
    var listHD = parsedJson['sd_homeDetail'] as List;
    print('tipo de dato en lista de sd_homeDetail: ${listHD.runtimeType}'); //returns List<dynamic>
    List<HomeDetail> sdHomeDetailList = listHD.map((i) => HomeDetail.fromJson(i)).toList();

    var listSD = parsedJson['sd_spendDetail'] as List;
    print('tipo de dato en lista de sd_spendDetail: ${listSD.runtimeType}'); //returns List<dynamic>
    List<SpendDetail> sdSpendDetailList = listSD.map((i) => SpendDetail.fromJson(i)).toList();

    return Spend(
      id: parsedJson['id'],
      date: parsedJson['date'],
      description: parsedJson['description'],
      amount: parsedJson['amount'],
      sd_homeDetail: sdHomeDetailList,
      sd_spendDetail: sdSpendDetailList,
    );
  }
}

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
