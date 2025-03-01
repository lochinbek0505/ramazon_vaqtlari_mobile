class ProvinceModel {
  String province;
  List<DistrictModel> list;

  ProvinceModel(this.province, this.list);
}

class DistrictModel {
  String name;
  String path;

  DistrictModel(this.name, this.path);
}
