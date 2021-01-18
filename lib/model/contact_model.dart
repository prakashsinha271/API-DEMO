class ContactModel {
  ContactModel({
    this.name,
    this.number,
  });

  String name;
  String number;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        name: json["name"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "number": number,
      };
}
