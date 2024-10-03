class CompaniesEmail {
  var id;
  final String emailAddress;
  final String companyName;
  final String website;
  final bool visible;
  final String addedBy;
  final String createdAt;
  final String updatedAt;

  CompaniesEmail({
    required this.id,
    required this.emailAddress,
    required this.companyName,
    required this.website,
    required this.visible,
    required this.addedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CompaniesEmail.fromJson(Map<String, dynamic> json) {
    return CompaniesEmail(
      id: json['id'],
      emailAddress: json['email_address'],
      companyName: json['company_name'],
      website: json['website'],
      visible: json['visible'],
      addedBy: json['added_by'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
