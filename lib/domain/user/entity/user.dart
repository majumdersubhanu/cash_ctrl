import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  factory User({
    int? id,
    String? username,
    String? email,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    String? password,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'date_of_birth') DateTime? dateOfBirth,
    String? gender,
    @JsonKey(name: 'current_address') String? currentAddress,
    String? nationality,
    @JsonKey(name: 'profile_pic') String? profilePic,
    @JsonKey(name: 'job_title') String? jobTitle,
    @JsonKey(name: 'company_name') String? companyName,
    @JsonKey(name: 'employment_status') String? employmentStatus,
    @JsonKey(name: 'monthly_income') String? monthlyIncome,
    @JsonKey(name: 'account_number') String? accountNumber,
    @JsonKey(name: 'ifsc_code') String? ifscCode,
    @JsonKey(name: 'bank_name') String? bankName,
    @JsonKey(name: 'upi_id') String? upiId,
    @JsonKey(name: 'pan_card') String? panCard,
    @JsonKey(name: 'aadhaar_card') String? aadhaarCard,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
