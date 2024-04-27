import 'package:json_annotation/json_annotation.dart';

part 'estados_model.g.dart';

@JsonSerializable()
class EstadosModel {
  int? id;
  String? sigla;
  String? nome;

  EstadosModel();

  static List<EstadosModel> listFromJson(List list) {
    List<EstadosModel> listReturn = [];
    for (var element in list) {
      EstadosModel estadosModel = EstadosModel.fromJson(element);
      listReturn.add(estadosModel);
    }
    return listReturn;
  }

  factory EstadosModel.fromJson(Map<String, dynamic> json) =>
      _$EstadosModelFromJson(json);

  Map<String, dynamic> toJson() => _$EstadosModelToJson(this);
}
