class User {
  String homeCountry;
  bool admin;
  String Address;
  String Email;
  String Name;
  String Contact_no;

  User(this.homeCountry);

  Map<String, dynamic> toJson() => {
    'homeCountry': homeCountry,
    'admin': admin,
    'Address':Address,
    'Email': Email,
    'Name':Name ,
    'Contact_no':Contact_no,
  };
}