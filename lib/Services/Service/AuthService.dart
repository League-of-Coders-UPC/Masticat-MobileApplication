import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../model/Seguridad/LoginResponse.dart';
import '../../model/Seguridad/RefreshTokenRequest.dart';

part 'AuthService.g.dart';

@RestApi(baseUrl: "https://animal-shelter-p65z.onrender.com/api")
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST("/token/")
  Future<LoginResponse> login(@Body() Map<String, dynamic> loginRequest);

  @POST("/token/refresh/")
  Future<LoginResponse> refresh(@Body() RefreshTokenRequest refreshTokenRequest);
}
