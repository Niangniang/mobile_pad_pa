
import 'package:json_annotation/json_annotation.dart';
import 'package:mobile_pad_pa/models/model_evenement/model_evenement.dart';
part 'model_rdv.g.dart';

@JsonSerializable(explicitToJson: true)
class RDV{
String? id;
DateTime? date;
String? description;
double? age;
String? secteurAtivites;
String? typeRdv;
User? user;
ObjetRDV? objetRDV;
Creneau? creneau;
String? etatRdv;



RDV({this.id, this.date, this.description, this.age, this.secteurAtivites,
    this.typeRdv, this.user, this.objetRDV, this.creneau, this.etatRdv});

factory RDV.fromJson(Map<String, dynamic> json) =>
    _$RDVFromJson(json);
Map<String, dynamic> toJson() => _$RDVToJson(this);

}


@JsonSerializable(explicitToJson: false)
class ObjetRDV {
String? id;
String? objet;

ObjetRDV({this.id, this.objet});

factory ObjetRDV.fromJson(Map<String, dynamic> json) =>
    _$ObjetRDVFromJson(json);
Map<String, dynamic> toJson() => _$ObjetRDVToJson(this);


}

@JsonSerializable(explicitToJson: true)
class Creneau {
String? id;
DateTime? debut;
DateTime? fin;
bool? disponibilite;
DateTime? date;
PersonneDemande? personneDemande;

Creneau({this.id, this.debut, this.fin, this.disponibilite, this.date,
      this.personneDemande});

factory Creneau.fromJson(Map<String, dynamic> json) =>
    _$CreneauFromJson(json);
Map<String, dynamic> toJson() => _$CreneauToJson(this);
}

@JsonSerializable(explicitToJson: false)
class PersonneDemande{
String? id;
String? prenom;
String? nom;
String? nomPoste;
String? mail;
String? fileUrl;

PersonneDemande({
      this.id, this.prenom, this.nom, this.nomPoste, this.mail, this.fileUrl});


factory PersonneDemande.fromJson(Map<String, dynamic> json) =>
    _$PersonneDemandeFromJson(json);
Map<String, dynamic> toJson() => _$PersonneDemandeToJson(this);
}