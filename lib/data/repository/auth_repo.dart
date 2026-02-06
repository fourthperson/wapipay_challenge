import 'package:wapipay_challenge/data/source/api/api_data_source.dart';
import 'package:wapipay_challenge/domain/entity/auth_result.dart';
import 'package:wapipay_challenge/domain/entity/otp_result.dart';
import 'package:wapipay_challenge/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final ApiDataSource _apiDataSource;

  AuthRepositoryImpl({required ApiDataSource apiDataSource})
    : _apiDataSource = apiDataSource;

  @override
  Future<AuthResult> authenticate(String phone) async {
    final AuthResult result = await _apiDataSource.authenticate(phone);
    return result;
  }

  @override
  Future<OtpResult> verifyOtp(String phone, String otp) async {
    final OtpResult result = await _apiDataSource.verifyOtp(phone, otp);
    return result;
  }
}
