class userDetails {
  String cne;
  String nom;
  String prenom;
  String Id_User;

  userDetails({this.cne, this.nom, this.prenom, this.Id_User});
  userDetails.fromJson(Map<String, dynamic> json) {
    cne = json['CNE_ET'];
    nom = json['NOM_USER'];
    prenom = json['PRENOM_USER'];
    Id_User = json['Id_User'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cne'] = cne;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['Id_User'] = Id_User;
    return data;
  }
}
/*

class userDetails {
  String? cne;
  String? nom;
  String? prenom;
  String? Id_User;
  String? etat;

userDetails({
  this.cne,
  this.nom,
  this.prenom,
  this.Id_User,
  this.etat
  });
userDetails.fromJson(Map<String, dynamic> json) {
    cne = json['CNE_ET'];
    nom = json['NOM_USER'];
    prenom = json['PRENOM_USER'];
    Id_User = json['Id_User'];
    etat = json['etat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cne'] = cne;
    data['nom'] = nom;
    data['prenom'] = prenom;
    data['Id_User'] = Id_User;
    data['etat'] = etat;
    return data;
  }

*/
