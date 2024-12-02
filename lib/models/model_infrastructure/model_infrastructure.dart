
import 'package:json_annotation/json_annotation.dart';
part 'model_infrastructure.g.dart';

@JsonSerializable(explicitToJson: true)
class Infrastructure{
  String? id;
  String nom;
  String? adresse;
  String? dateinsertion;
  double? coutHoraire;
  int? capacite;
  List<TypeEvenement>? typeEvenements;
  String? fileUrl;
  TypeInfrastructure? typeInfrastructure;
  String? commentaire;
  bool? isActive;

  Infrastructure({
    this.id,
    required this.nom,
    this.adresse,
    this.dateinsertion,
    this.coutHoraire,
    this.capacite,
    this.typeEvenements,
    this.fileUrl,
    this.commentaire,
    this.typeInfrastructure,
    this.isActive
    });

  factory Infrastructure.fromJson(Map<String, dynamic> json) =>
      _$InfrastructureFromJson(json);
  Map<String, dynamic> toJson() => _$InfrastructureToJson(this);
}

@JsonSerializable(explicitToJson: false)
class TypeEvenement{
String? id;
String?  libelle;
double? duree;
double? cout;
bool? isActive;

TypeEvenement({
  this.id,
  this.duree,
  this.libelle,
  this.cout,
  this.isActive

});

factory TypeEvenement.fromJson(Map<String, dynamic> json) =>
    _$TypeEvenementFromJson(json);
Map<String, dynamic> toJson() => _$TypeEvenementToJson(this);

}


@JsonSerializable(explicitToJson: false)
class TypeInfrastructure{
  String? id;
  String?  libelle;
  bool? isActive;
  String? fileUrl;



  TypeInfrastructure({
    this.id,
    this.libelle,
    this.isActive,
    this.fileUrl,
  });

  factory TypeInfrastructure.fromJson(Map<String, dynamic> json) =>
      _$TypeInfrastructureFromJson(json);
  Map<String, dynamic> toJson() => _$TypeInfrastructureToJson(this);

}

