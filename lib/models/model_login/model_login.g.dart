// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthLogin _$AuthLoginFromJson(Map<String, dynamic> json) => AuthLogin(
      refresh: json['refresh'] as String,
      access: json['access'] as String,
      expiration: json['expiration'] as String,
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthLoginToJson(AuthLogin instance) => <String, dynamic>{
      'refresh': instance.refresh,
      'access': instance.access,
      'expiration': instance.expiration,
      'user': instance.user.toJson(),
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      id: json['id'] as String?,
      nom: json['nom'] as String?,
      prenom: json['prenom'] as String?,
      email: json['email'] as String?,
      telephone: json['telephone'] as String?,
      adresse: json['adresse'] as String?,
      profil: json['profil'] == null
          ? null
          : Profil.fromJson(json['profil'] as Map<String, dynamic>),
      is_active: json['is_active'] as bool?,
      is_admin: json['is_admin'] as bool?,
      attachement: json['attachement'] as String?,
      statut: json['statut'] as bool?,
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'id': instance.id,
      'nom': instance.nom,
      'prenom': instance.prenom,
      'email': instance.email,
      'is_active': instance.is_active,
      'is_admin': instance.is_admin,
      'profil': instance.profil?.toJson(),
      'statut': instance.statut,
      'telephone': instance.telephone,
      'adresse': instance.adresse,
      'attachement': instance.attachement,
    };

Profil _$ProfilFromJson(Map<String, dynamic> json) => Profil(
      id: json['id'] as String?,
      intitule: json['intitule'] as String?,
      dateInsertion: json['dateInsertion'] as String?,
    );

Map<String, dynamic> _$ProfilToJson(Profil instance) => <String, dynamic>{
      'id': instance.id,
      'intitule': instance.intitule,
      'dateInsertion': instance.dateInsertion,
    };
