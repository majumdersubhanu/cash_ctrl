// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      phoneNumber: json['phone_number'] as String?,
      password: json['password'] as String?,
      fullName: json['full_name'] as String?,
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      gender: json['gender'] as String?,
      currentAddress: json['current_address'] as String?,
      nationality: json['nationality'] as String?,
      profilePic: json['profile_pic'] as String?,
      jobTitle: json['job_title'] as String?,
      companyName: json['company_name'] as String?,
      employmentStatus: json['employment_status'] as String?,
      monthlyIncome: json['monthly_income'] as String?,
      accountNumber: json['account_number'] as String?,
      ifscCode: json['ifsc_code'] as String?,
      bankName: json['bank_name'] as String?,
      upiId: json['upi_id'] as String?,
      panCard: json['pan_card'] as String?,
      aadhaarCard: json['aadhaar_card'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'password': instance.password,
      'full_name': instance.fullName,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
      'gender': instance.gender,
      'current_address': instance.currentAddress,
      'nationality': instance.nationality,
      'profile_pic': instance.profilePic,
      'job_title': instance.jobTitle,
      'company_name': instance.companyName,
      'employment_status': instance.employmentStatus,
      'monthly_income': instance.monthlyIncome,
      'account_number': instance.accountNumber,
      'ifsc_code': instance.ifscCode,
      'bank_name': instance.bankName,
      'upi_id': instance.upiId,
      'pan_card': instance.panCard,
      'aadhaar_card': instance.aadhaarCard,
    };
