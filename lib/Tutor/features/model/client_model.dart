class ClientModel {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String phonenumber;
  final String dateOfBirth;
  final String gender;
  final bool isActive;
  final String clientStatus;
  final String allocationStatus;
  final String paymentMethod;
  final String relationship;
  final dynamic source;
  final String affiliate;
  final String addressLine;
  final String townOrCity;
  final String country;
  final String state;
  final String postCode;
  final String secondContactName;
  final String secondContactRelationship;
  final String secondContactPhone;
  final String paymentGateway;
  final String clientPhoto;

  ClientModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phonenumber,
    required this.dateOfBirth,
    required this.gender,
    required this.isActive,
    required this.clientStatus,
    required this.allocationStatus,
    required this.paymentMethod,
    required this.relationship,
    required this.source,
    required this.affiliate,
    required this.addressLine,
    required this.townOrCity,
    required this.country,
    required this.state,
    required this.postCode,
    required this.secondContactName,
    required this.secondContactRelationship,
    required this.secondContactPhone,
    required this.paymentGateway,
    required this.clientPhoto,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      username: json['username'],
      email: json['email'],
      phonenumber: json['phonenumber'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      isActive: json['is_active'],
      clientStatus: json['client_status'],
      allocationStatus: json['allocation_status'],
      paymentMethod: json['payment_method'],
      relationship: json['relationship'],
      source: json['source']?.toString() ??
          '', // Convert to String regardless of its type
      affiliate: json['affiliate'] ?? '',
      addressLine: json['address_line'] ?? '',
      townOrCity: json['town_or_city'] ?? '',
      country: json['country']?.toString() ??
          '', // Convert country to string as well, in case it's an int
      state: json['state'] ?? '',
      postCode: json['post_code'] ?? '',
      secondContactName: json['second_contact_name'] ?? '',
      secondContactRelationship: json['second_contact_relationship'] ?? '',
      secondContactPhone: json['second_contact_phone'] ?? '',
      paymentGateway: json['payment_gateway'] ?? '',
      clientPhoto: json['client_photo'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ClientModel(id: $id, firstName: $firstName, lastName: $lastName, username: $username, email: $email, phonenumber: $phonenumber, dateOfBirth: $dateOfBirth, gender: $gender, isActive: $isActive, clientStatus: $clientStatus, allocationStatus: $allocationStatus, paymentMethod: $paymentMethod, relationship: $relationship, source: $source, affiliate: $affiliate, addressLine: $addressLine, townOrCity: $townOrCity, country: $country, state: $state, postCode: $postCode, secondContactName: $secondContactName, secondContactRelationship: $secondContactRelationship, secondContactPhone: $secondContactPhone, paymentGateway: $paymentGateway, clientPhoto: $clientPhoto)';
  }
}
