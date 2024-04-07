class Profile {
  PersonalInformation? personalInformation;
  EmploymentDetails? employmentDetails;
  FinancialInformation? financialInformation;
  IdentificationDocuments? identificationDocuments;

  Profile(
      {this.personalInformation,
      this.employmentDetails,
      this.financialInformation,
      this.identificationDocuments});

  Profile.fromJson(Map<String, dynamic> json) {
    personalInformation = json['personal_information'] != null
        ? PersonalInformation?.fromJson(json['personal_information'])
        : null;
    employmentDetails = json['employment_details'] != null
        ? EmploymentDetails?.fromJson(json['employment_details'])
        : null;
    financialInformation = json['financial_information'] != null
        ? FinancialInformation?.fromJson(json['financial_information'])
        : null;
    identificationDocuments = json['identification_documents'] != null
        ? IdentificationDocuments?.fromJson(json['identification_documents'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (personalInformation != null) {
      data['personal_information'] = personalInformation?.toJson();
    }
    if (employmentDetails != null) {
      data['employment_details'] = employmentDetails?.toJson();
    }
    if (financialInformation != null) {
      data['financial_information'] = financialInformation?.toJson();
    }
    if (identificationDocuments != null) {
      data['identification_documents'] = identificationDocuments?.toJson();
    }
    return data;
  }
}

class PersonalInformation {
  String? fullName;
  String? dateOfBirth;
  String? gender;
  ContactInformation? contactInformation;
  Address? address;
  String? nationality;

  PersonalInformation(
      {this.fullName,
      this.dateOfBirth,
      this.gender,
      this.contactInformation,
      this.address,
      this.nationality});

  PersonalInformation.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    contactInformation = json['contact_information'] != null
        ? ContactInformation?.fromJson(json['contact_information'])
        : null;
    address =
        json['address'] != null ? Address?.fromJson(json['address']) : null;
    nationality = json['nationality'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    if (contactInformation != null) {
      data['contact_information'] = contactInformation?.toJson();
    }
    if (address != null) {
      data['address'] = address?.toJson();
    }
    data['nationality'] = nationality;
    return data;
  }
}

class ContactInformation {
  String? email;
  String? phoneNumber;

  ContactInformation({this.email, this.phoneNumber});

  ContactInformation.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    return data;
  }
}

class Address {
  String? current;

  Address({this.current});

  Address.fromJson(Map<String, dynamic> json) {
    current = json['current'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['current'] = current;
    return data;
  }
}

class EmploymentDetails {
  String? jobTitle;
  String? companyName;
  String? industry;
  String? employmentStatus;
  String? monthlyIncome;

  EmploymentDetails(
      {this.jobTitle,
      this.companyName,
      this.industry,
      this.employmentStatus,
      this.monthlyIncome});

  EmploymentDetails.fromJson(Map<String, dynamic> json) {
    jobTitle = json['job_title'];
    companyName = json['company_name'];
    industry = json['industry'];
    employmentStatus = json['employment_status'];
    monthlyIncome = json['monthly_income'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['job_title'] = jobTitle;
    data['company_name'] = companyName;
    data['industry'] = industry;
    data['employment_status'] = employmentStatus;
    data['monthly_income'] = monthlyIncome;
    return data;
  }
}

class FinancialInformation {
  BankAccountDetails? bankAccountDetails;
  String? upiId;

  FinancialInformation({this.bankAccountDetails, this.upiId});

  FinancialInformation.fromJson(Map<String, dynamic> json) {
    bankAccountDetails = json['bank_account_details'] != null
        ? BankAccountDetails?.fromJson(json['bank_account_details'])
        : null;
    upiId = json['upi_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (bankAccountDetails != null) {
      data['bank_account_details'] = bankAccountDetails?.toJson();
    }
    data['upi_id'] = upiId;
    return data;
  }
}

class BankAccountDetails {
  String? accountNumber;
  String? ifscCode;
  String? bankName;

  BankAccountDetails({this.accountNumber, this.ifscCode, this.bankName});

  BankAccountDetails.fromJson(Map<String, dynamic> json) {
    accountNumber = json['account_number'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['account_number'] = accountNumber;
    data['ifsc_code'] = ifscCode;
    data['bank_name'] = bankName;
    return data;
  }
}

class IdentificationDocuments {
  String? panCard;
  String? aadhaarCard;
  String? passport;
  String? driverLicense;

  IdentificationDocuments(
      {this.panCard, this.aadhaarCard, this.passport, this.driverLicense});

  IdentificationDocuments.fromJson(Map<String, dynamic> json) {
    panCard = json['pan_card'];
    aadhaarCard = json['aadhaar_card'];
    passport = json['passport'];
    driverLicense = json['driver_license'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pan_card'] = panCard;
    data['aadhaar_card'] = aadhaarCard;
    data['passport'] = passport;
    data['driver_license'] = driverLicense;
    return data;
  }
}
