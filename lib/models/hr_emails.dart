// hr_email.dart
class HrEmail {
  final String emailAddress;
  final String companyName;
  final String website;
  final String addedBy;

  HrEmail({
    required this.emailAddress,
    required this.companyName,
    required this.website,
    required this.addedBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'email_address': emailAddress,
      'company_name': companyName,
      'website': website,
      'added_by': addedBy,
    };
  }
}
