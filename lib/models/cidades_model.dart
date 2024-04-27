import 'package:json_annotation/json_annotation.dart';

part 'cidades_model.g.dart';

@JsonSerializable()
class CidadesModel {

  String? nome;


  CidadesModel();

  static List<CidadesModel> listFromJson(List list) {
    List<CidadesModel> listReturn = [];
    for (var element in list) {
      CidadesModel cidadesModel = CidadesModel.fromJson(element);
      listReturn.add(cidadesModel);
    }
    return listReturn;
  }

  factory CidadesModel.fromJson(Map<String, dynamic> json) =>
      _$CidadesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CidadesModelToJson(this);
}
