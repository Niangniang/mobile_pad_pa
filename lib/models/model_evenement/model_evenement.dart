import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_pad_pa/models/model_creneau/model_creneau.dart';
part 'model_evenement.g.dart';



@JsonSerializable(explicitToJson: true)
class Evenement {

 String? id;
 String? description;
 String? nomEvenement;
 CreneauEvent? creneau;
 String? statut;
 TypeEvenement? typeEvenement;
 Paiement? paiement;
 User? user;
 bool? estRecurrent;
 String? frequence;
 DateTime? dateInsertion;
 String? fileUrl;

 Evenement({
     this.id,
     this.description,
     this.nomEvenement,
     this.creneau,
     this.statut,
     this.typeEvenement,
     this.paiement,
     this.user,
     this.estRecurrent,
     this.frequence,
     this.dateInsertion,
     this.fileUrl

 });

 factory Evenement.fromJson(Map<String, dynamic> json) =>
     _$EvenementFromJson(json);

 Map<String, dynamic> toJson() => _$EvenementToJson(this);

}


@JsonSerializable(explicitToJson: false)
class TypeEvenement{
 String? id;
 String? libelle;
 int? duree;
 double? cout;

 TypeEvenement({
  this.id,
  this.libelle,
  this.duree,
  this.cout

 });

 factory TypeEvenement.fromJson(Map<String, dynamic> json) =>
     _$TypeEvenementFromJson(json);

 Map<String, dynamic> toJson() => _$TypeEvenementToJson(this);



 @override
 String toString() {
  // Format: "Libelle dureeH - cout FCFA"
  return '$libelle ${duree}H - ${cout?.toStringAsFixed(0).replaceAll('.', ',')} FCFA';
 }

}


@JsonSerializable(explicitToJson: false)
class Paiement{

 String? id;
 bool? statutPaiement;
 DateTime? datePaiement;
 String? montantPaiement;

 Paiement({
  this.id,
  this.datePaiement,
  this.montantPaiement,
  this.statutPaiement

 });

 factory Paiement.fromJson(Map<String, dynamic> json) =>
     _$PaiementFromJson(json);

 Map<String, dynamic> toJson() => _$PaiementToJson(this);

}

@JsonSerializable(explicitToJson: true)
class User{
 String? id;
 String? nom;
 String? prenom;

 String? email;

 bool? is_active;

 bool? is_admin;

 Profil? profil;

 bool? statut;

 String? telephone;

 String? adresse;

 String? username;

 User({
  this.adresse,
  this.statut,
  this.id,
  this.is_admin,
  this.is_active,
  this.profil,
  this.telephone,
  this.prenom,
  this.email,
  this.nom,
  this.username
});

 factory User.fromJson(Map<String, dynamic> json) =>
     _$UserFromJson(json);

 Map<String, dynamic> toJson() => _$UserToJson(this);
}


@JsonSerializable(explicitToJson: false)
class Profil {
 String? id;
 String? intitule;
 DateTime? dateInsertion;



 Profil({ this.id, this.intitule,  this.dateInsertion});

 factory Profil.fromJson(Map<String, dynamic> json) =>
     _$ProfilFromJson(json);

 Map<String, dynamic> toJson() => _$ProfilToJson(this);
}