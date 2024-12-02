// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_announcement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Announcement _$AnnouncementFromJson(Map<String, dynamic> json) => Announcement(
      id: json['id'] as String?,
      description: json['description'] as String?,
      dateCreation: json['dateCreation'] == null
          ? null
          : DateTime.parse(json['dateCreation'] as String),
      imageUrl: json['imageUrl'] as String?,
      location: json['location'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$AnnouncementToJson(Announcement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'name': instance.name,
      'location': instance.location,
      'dateCreation': instance.dateCreation?.toIso8601String(),
      'imageUrl': instance.imageUrl,
    };

Categorie _$CategorieFromJson(Map<String, dynamic> json) => Categorie(
      id: json['id'] as String?,
      libelle: json['libelle'] as String?,
    );

Map<String, dynamic> _$CategorieToJson(Categorie instance) => <String, dynamic>{
      'id': instance.id,
      'libelle': instance.libelle,
    };
