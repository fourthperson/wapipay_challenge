import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wapipay_challenge/domain/entity/user.dart';

part 'user_api_model.freezed.dart';

part 'user_api_model.g.dart';

@freezed
abstract class UserApiModel with _$UserApiModel {
  const UserApiModel._();

  const factory UserApiModel({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'phone') String? phone,
    @JsonKey(name: 'fullName') String? fullName,
    @JsonKey(name: 'otp') String? otp,
    @JsonKey(name: 'pin') String? pin,
  }) = _UserApiModel;

  factory UserApiModel.fromJson(Map<String, Object?> json) =>
      _$UserApiModelFromJson(json);

  User toDomain() {
    return User(
      id: id ?? '',
      phone: phone ?? '',
      name: fullName ?? '',
      otp: otp ?? '',
      pin: pin ?? '',
    );
  }

  factory UserApiModel.fromDomain(User user) {
    return UserApiModel(
      id: user.id,
      phone: user.phone,
      fullName: user.name,
      otp: user.otp,
      pin: user.pin,
    );
  }
}
