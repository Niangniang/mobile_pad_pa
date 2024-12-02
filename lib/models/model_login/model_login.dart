import 'package:json_annotation/json_annotation.dart';
part 'model_login.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthLogin {
  String refresh;
  String access;
  String expiration;

  UserData user;

  AuthLogin({
    required this.refresh,
    required this.access,
    required this.expiration,
    required this.user,
  });

  factory AuthLogin.fromJson(Map<String, dynamic> json) =>
      _$AuthLoginFromJson(json);

  Map<String, dynamic> toJson() => _$AuthLoginToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UserData {
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
  String? attachement;


  UserData({ this.id , this.nom, this.prenom,
     this.email, this.telephone, this.adresse,
    this.profil, this.is_active, this.is_admin,this.attachement,
    this.statut});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable(explicitToJson: false)
class Profil {
  String? id;
  String? intitule;
  String? dateInsertion;



  Profil({ this.id, this.intitule,  this.dateInsertion});

  factory Profil.fromJson(Map<String, dynamic> json) =>
      _$ProfilFromJson(json);

  Map<String, dynamic> toJson() => _$ProfilToJson(this);
}




