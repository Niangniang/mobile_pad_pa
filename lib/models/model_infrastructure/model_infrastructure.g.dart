// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_infrastructure.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Infrastructure _$InfrastructureFromJson(Map<String, dynamic> json) =>
    Infrastructure(
      id: json['id'] as String?,
      nom: json['nom'] as String,
      adresse: json['adresse'] as String?,
      dateinsertion: json['dateinsertion'] as String?,
      coutHoraire: (json['coutHoraire'] as num?)?.toDouble(),
      capacite: (json['capacite'] as num?)?.toInt(),
      typeEvenements: (json['typeEvenements'] as List<dynamic>?)
          ?.map((e) => TypeEvenement.fromJson(e as Map<String, dynamic>))
          .toList(),
      fileUrl: json['fileUrl'] as String?,
      commentaire: json['commentaire'] as String?,
      typeInfrastructure: json['typeInfrastructure'] == null
          ? null
          : TypeInfrastructure.fromJson(
              json['typeInfrastructure'] as Map<String, dynamic>),
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$InfrastructureToJson(Infrastructure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'adresse': instance.adresse,
      'dateinsertion': instance.dateinsertion,
      'coutHoraire': instance.coutHoraire,
      'capacite': instance.capacite,
      'typeEvenements':
          instance.typeEvenements?.map((e) => e.toJson()).toList(),
      'fileUrl': instance.fileUrl,
      'typeInfrastructure': instance.typeInfrastructure?.toJson(),
      'commentaire': instance.commentaire,
      'isActive': instance.isActive,
    };

TypeEvenement _$TypeEvenementFromJson(Map<String, dynamic> json) =>
    TypeEvenement(
      id: json['id'] as String?,
      duree: (json['duree'] as num?)?.toDouble(),
      libelle: json['libelle'] as String?,
      cout: (json['cout'] as num?)?.toDouble(),
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$TypeEvenementToJson(TypeEvenement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'libelle': instance.libelle,
      'duree': instance.duree,
      'cout': instance.cout,
      'isActive': instance.isActive,
    };

TypeInfrastructure _$TypeInfrastructureFromJson(Map<String, dynamic> json) =>
    TypeInfrastructure(
      id: json['id'] as String?,
      libelle: json['libelle'] as String?,
      isActive: json['isActive'] as bool?,
      fileUrl: json['fileUrl'] as String?,
    );

Map<String, dynamic> _$TypeInfrastructureToJson(TypeInfrastructure instance) =>
    <String, dynamic>{
      'id': instance.id,
      'libelle': instance.libelle,
      'isActive': instance.isActive,
      'fileUrl': instance.fileUrl,
    };
