// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notif _$NotifFromJson(Map<String, dynamic> json) => Notif(
      id: json['id'] as String?,
      titre: json['titre'] as String?,
      message: json['message'] as String?,
      dateHeure: json['dateHeure'] as String?,
    );

Map<String, dynamic> _$NotifToJson(Notif instance) => <String, dynamic>{
      'id': instance.id,
      'titre': instance.titre,
      'message': instance.message,
      'dateHeure': instance.dateHeure,
    };
