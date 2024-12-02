// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      prenom: json['prenom'] as String,
      nom: json['nom'] as String,
      adresse: json['adresse'] as String,
      password: json['password'] as String,
      telephone: json['telephone'] as String,
      email: json['email'] as String,
      attachement: json['attachement'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'prenom': instance.prenom,
      'nom': instance.nom,
      'adresse': instance.adresse,
      'password': instance.password,
      'telephone': instance.telephone,
      'email': instance.email,
      'attachement': instance.attachement,
    };
