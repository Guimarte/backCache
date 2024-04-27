// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estados_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstadosModel _$EstadosModelFromJson(Map<String, dynamic> json) => EstadosModel()
  ..id = (json['id'] as num?)?.toInt()
  ..sigla = json['sigla'] as String?
  ..nome = json['nome'] as String?;

Map<String, dynamic> _$EstadosModelToJson(EstadosModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sigla': instance.sigla,
      'nome': instance.nome,
    };
