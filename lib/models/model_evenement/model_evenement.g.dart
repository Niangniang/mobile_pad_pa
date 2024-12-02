// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_evenement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Evenement _$EvenementFromJson(Map<String, dynamic> json) => Evenement(
      id: json['id'] as String?,
      description: json['description'] as String?,
      nomEvenement: json['nomEvenement'] as String?,
      creneau: json['creneau'] == null
          ? null
          : CreneauEvent.fromJson(json['creneau'] as Map<String, dynamic>),
      statut: json['statut'] as String?,
      typeEvenement: json['typeEvenement'] == null
          ? null
          : TypeEvenement.fromJson(
              json['typeEvenement'] as Map<String, dynamic>),
      paiement: json['paiement'] == null
          ? null
          : Paiement.fromJson(json['paiement'] as Map<String, dynamic>),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      estRecurrent: json['estRecurrent'] as bool?,
      frequence: json['frequence'] as String?,
      dateInsertion: json['dateInsertion'] == null
          ? null
          : DateTime.parse(json['dateInsertion'] as String),
      fileUrl: json['fileUrl'] as String?,
    );

Map<String, dynamic> _$EvenementToJson(Evenement instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'nomEvenement': instance.nomEvenement,
      'creneau': instance.creneau?.toJson(),
      'statut': instance.statut,
      'typeEvenement': instance.typeEvenement?.toJson(),
      'paiement': instance.paiement?.toJson(),
      'user': instance.user?.toJson(),
      'estRecurrent': instance.estRecurrent,
      'frequence': instance.frequence,
      'dateInsertion': instance.dateInsertion?.toIso8601String(),
      'fileUrl': instance.fileUrl,
    };

TypeEvenement _$TypeEvenementFromJson(Map<String, dynamic> json) =>
    TypeEvenement(
      id: json['id'] as String?,
      libelle: json['libelle'] as String?,
      duree: (json['duree'] as num?)?.toInt(),
      cout: (json['cout'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TypeEvenementToJson(TypeEvenement instance) =>
    <String, dynamic>{
      'id': instance.id,
      'libelle': instance.libelle,
      'duree': instance.duree,
      'cout': instance.cout,
    };

Paiement _$PaiementFromJson(Map<String, dynamic> json) => Paiement(
      id: json['id'] as String?,
      datePaiement: json['datePaiement'] == null
          ? null
          : DateTime.parse(json['datePaiement'] as String),
      montantPaiement: json['montantPaiement'] as String?,
      statutPaiement: json['statutPaiement'] as bool?,
    );

Map<String, dynamic> _$PaiementToJson(Paiement instance) => <String, dynamic>{
      'id': instance.id,
      'statutPaiement': instance.statutPaiement,
      'datePaiement': instance.datePaiement?.toIso8601String(),
      'montantPaiement': instance.montantPaiement,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      adresse: json['adresse'] as String?,
      statut: json['statut'] as bool?,
      id: json['id'] as String?,
      is_admin: json['is_admin'] as bool?,
      is_active: json['is_active'] as bool?,
      profil: json['profil'] == null
          ? null
          : Profil.fromJson(json['profil'] as Map<String, dynamic>),
      telephone: json['telephone'] as String?,
      prenom: json['prenom'] as String?,
      email: json['email'] as String?,
      nom: json['nom'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
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
      'username': instance.username,
    };

Profil _$ProfilFromJson(Map<String, dynamic> json) => Profil(
      id: json['id'] as String?,
      intitule: json['intitule'] as String?,
      dateInsertion: json['dateInsertion'] == null
          ? null
          : DateTime.parse(json['dateInsertion'] as String),
    );

Map<String, dynamic> _$ProfilToJson(Profil instance) => <String, dynamic>{
      'id': instance.id,
      'intitule': instance.intitule,
      'dateInsertion': instance.dateInsertion?.toIso8601String(),
    };
