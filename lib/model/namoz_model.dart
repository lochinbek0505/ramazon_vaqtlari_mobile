class HijriDate {
  String? month;
  num? day;

  HijriDate({this.month, this.day});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["month"] = month;
    map["day"] = day;
    return map;
  }

  HijriDate.fromJson(dynamic json){
    month = json["month"];
    day = json["day"];
  }
}

class Times {
  String? tongSaharlik;
  String? quyosh;
  String? peshin;
  String? asr;
  String? shomIftor;
  String? hufton;

  Times(
      {this.tongSaharlik, this.quyosh, this.peshin, this.asr, this.shomIftor, this.hufton});

  @override
  String toString() {
    return 'Times{tongSaharlik: $tongSaharlik, quyosh: $quyosh, peshin: $peshin, asr: $asr, shomIftor: $shomIftor, hufton: $hufton}';
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["tong_saharlik"] = tongSaharlik;
    map["quyosh"] = quyosh;
    map["peshin"] = peshin;
    map["asr"] = asr;
    map["shom_iftor"] = shomIftor;
    map["hufton"] = hufton;
    return map;
  }

  Times.fromJson(dynamic json){
    tongSaharlik = json["tong_saharlik"];
    quyosh = json["quyosh"];
    peshin = json["peshin"];
    asr = json["asr"];
    shomIftor = json["shom_iftor"];
    hufton = json["hufton"];
  }
}

class DataList {
  String? region;
  num? regionNumber;
  num? month;
  num? day;
  String? date;
  HijriDate? hijriDate;
  String? weekday;
  Times? times;

  DataList(
      {this.region, this.regionNumber, this.month, this.day, this.date, this.hijriDate, this.weekday, this.times});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["region"] = region;
    map["regionNumber"] = regionNumber;
    map["month"] = month;
    map["day"] = day;
    map["date"] = date;
    if (hijriDate != null) {
      map["hijri_date"] = hijriDate?.toJson();
    }
    map["weekday"] = weekday;
    if (times != null) {
      map["times"] = times?.toJson();
    }
    return map;
  }

  DataList.fromJson(dynamic json){
    region = json["region"];
    regionNumber = json["regionNumber"];
    month = json["month"];
    day = json["day"];
    date = json["date"];
    hijriDate =
    json["hijri_date"] != null ? HijriDate.fromJson(json["hijri_date"]) : null;
    weekday = json["weekday"];
    times = json["times"] != null ? Times.fromJson(json["times"]) : null;
  }
}

class NamozModel {
  List<DataList>? dataListList;

  NamozModel({this.dataListList});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (dataListList != null) {
      map["dataList"] = dataListList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  NamozModel.fromJson(dynamic json){
    if (json != null) {
      dataListList = [];
      json.forEach((v) {
        dataListList?.add(DataList.fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'NamozModel{dataListList: $dataListList}';
  }
}