class Times {
  String? kun;
  String? bomdod;
  String? quyosh;
  String? peshin;
  String? asr;
  String? shom;
  String? xufton;
  String? qamar;

  Times(
      {this.kun, this.bomdod, this.quyosh, this.peshin, this.asr, this.shom, this.xufton, this.qamar});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["Kun"] = kun;
    map["Bomdod"] = bomdod;
    map["Quyosh"] = quyosh;
    map["Peshin"] = peshin;
    map["Asr"] = asr;
    map["Shom"] = shom;
    map["Xufton"] = xufton;
    map["Qamar"] = qamar;
    return map;
  }

  Times.fromJson(dynamic json){
    kun = json["Kun"];
    bomdod = json["Bomdod"];
    quyosh = json["Quyosh"];
    peshin = json["Peshin"];
    asr = json["Asr"];
    shom = json["Shom"];
    xufton = json["Xufton"];
    qamar = json["Qamar"];
  }

  @override
  String toString() {
    return 'Times{kun: $kun, bomdod: $bomdod, quyosh: $quyosh, peshin: $peshin, asr: $asr, shom: $shom, xufton: $xufton, qamar: $qamar}';
  }

}

class NamozTimeModel {
  List<Times>? timesList;

  NamozTimeModel({this.timesList});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (timesList != null) {
      map["times"] = timesList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  NamozTimeModel.fromJson(dynamic json){
    if (json["times"] != null) {
      timesList = [];
      json["times"].forEach((v) {
        timesList?.add(Times.fromJson(v));
      });
    }
  }
}