class CompaniesEmail {
  final String emailAddress;
  final String addedBy;

  CompaniesEmail({
    required this.emailAddress,
    required this.addedBy,
  });

  factory CompaniesEmail.fromJson(Map<String, dynamic> json) {
    return CompaniesEmail(
      emailAddress: json['email_address'],
      addedBy: json['added_by'],
    );
  }
}
