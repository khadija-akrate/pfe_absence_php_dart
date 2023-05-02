class userDetails {
  String cne;
  String nom;
  String prenom;
  userDetails({
    this.cne,
    this.nom,
    this.prenom,
  });
  userDetails.fromJson(Map<String, dynamic> json) {
    cne = json['CNE_ET'];
    nom = json['NOM_USER'];
    prenom = json['PRENOM_USER'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cne'] = cne;
    data['nom'] = nom;
    data['prenom'] = prenom;
    return data;
  }
}
