import 'package:json_annotation/json_annotation.dart';
part 'model_announcement.g.dart';

@JsonSerializable(explicitToJson: true)
class Announcement {

  String?  id;
  String? description;
  String? name;
  String?  location;
  DateTime? dateCreation;
  String? imageUrl;

  Announcement({this.id, this.description, this.dateCreation,
    this.imageUrl, this.location, this.name
  });

  factory Announcement.fromJson(Map<String, dynamic> json) =>
      _$AnnouncementFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementToJson(this);

}


@JsonSerializable(explicitToJson: true)
class Categorie {
  String? id;
  String? libelle;

  Categorie({
    this.id,
    this.libelle

});

  factory Categorie.fromJson(Map<String, dynamic> json) =>
      _$CategorieFromJson(json);
  
  Map<String, dynamic> toJson() => _$CategorieToJson(this);

}