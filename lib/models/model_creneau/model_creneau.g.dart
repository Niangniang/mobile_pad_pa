// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_creneau.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreneauEvent _$CreneauEventFromJson(Map<String, dynamic> json) => CreneauEvent(
      id: json['id'] as String?,
      estDisponible: json['estDisponible'] as bool?,
      dateDebut: json['dateDebut'] == null
          ? null
          : DateTime.parse(json['dateDebut'] as String),
      dateFin: json['dateFin'] == null
          ? null
          : DateTime.parse(json['dateFin'] as String),
      infrastructure: json['infrastructure'] == null
          ? null
          : Infrastructure.fromJson(
              json['infrastructure'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreneauEventToJson(CreneauEvent instance) =>
    <String, dynamic>{
      'id': instance.id,
      'estDisponible': instance.estDisponible,
      'dateDebut': instance.dateDebut?.toIso8601String(),
      'dateFin': instance.dateFin?.toIso8601String(),
      'infrastructure': instance.infrastructure?.toJson(),
    };
