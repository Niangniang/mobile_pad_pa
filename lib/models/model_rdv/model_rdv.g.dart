// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_rdv.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RDV _$RDVFromJson(Map<String, dynamic> json) => RDV(
      id: json['id'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      description: json['description'] as String?,
      age: (json['age'] as num?)?.toDouble(),
      secteurAtivites: json['secteurAtivites'] as String?,
      typeRdv: json['typeRdv'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      objetRDV: json['objetRDV'] == null
          ? null
          : ObjetRDV.fromJson(json['objetRDV'] as Map<String, dynamic>),
      creneau: json['creneau'] == null
          ? null
          : Creneau.fromJson(json['creneau'] as Map<String, dynamic>),
      etatRdv: json['etatRdv'] as String?,
    );

Map<String, dynamic> _$RDVToJson(RDV instance) => <String, dynamic>{
      'id': instance.id,
      'date': instance.date?.toIso8601String(),
      'description': instance.description,
      'age': instance.age,
      'secteurAtivites': instance.secteurAtivites,
      'typeRdv': instance.typeRdv,
      'user': instance.user?.toJson(),
      'objetRDV': instance.objetRDV?.toJson(),
      'creneau': instance.creneau?.toJson(),
      'etatRdv': instance.etatRdv,
    };

ObjetRDV _$ObjetRDVFromJson(Map<String, dynamic> json) => ObjetRDV(
      id: json['id'] as String?,
      objet: json['objet'] as String?,
    );

Map<String, dynamic> _$ObjetRDVToJson(ObjetRDV instance) => <String, dynamic>{
      'id': instance.id,
      'objet': instance.objet,
    };

Creneau _$CreneauFromJson(Map<String, dynamic> json) => Creneau(
      id: json['id'] as String?,
      debut: json['debut'] == null
          ? null
          : DateTime.parse(json['debut'] as String),
      fin: json['fin'] == null ? null : DateTime.parse(json['fin'] as String),
      disponibilite: json['disponibilite'] as bool?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
      personneDemande: json['personneDemande'] == null
          ? null
          : PersonneDemande.fromJson(
              json['personneDemande'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreneauToJson(Creneau instance) => <String, dynamic>{
      'id': instance.id,
      'debut': instance.debut?.toIso8601String(),
      'fin': instance.fin?.toIso8601String(),
      'disponibilite': instance.disponibilite,
      'date': instance.date?.toIso8601String(),
      'personneDemande': instance.personneDemande?.toJson(),
    };

PersonneDemande _$PersonneDemandeFromJson(Map<String, dynamic> json) =>
    PersonneDemande(
      id: json['id'] as String?,
      prenom: json['prenom'] as String?,
      nom: json['nom'] as String?,
      nomPoste: json['nomPoste'] as String?,
      mail: json['mail'] as String?,
      fileUrl: json['fileUrl'] as String?,
    );

Map<String, dynamic> _$PersonneDemandeToJson(PersonneDemande instance) =>
    <String, dynamic>{
      'id': instance.id,
      'prenom': instance.prenom,
      'nom': instance.nom,
      'nomPoste': instance.nomPoste,
      'mail': instance.mail,
      'fileUrl': instance.fileUrl,
    };
