import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../model/Seguridad/SignupRequest.dart';
import '../../model/Seguridad/SignupResponse.dart';

part 'SignupService.g.dart';

@RestApi(baseUrl: "https://animal-shelter-p65z.onrender.com/api")
abstract class SignupService {
  factory SignupService(Dio dio, {String baseUrl}) = _SignupService;

  @POST("/signup/")
  Future<SignupResponse> signup(@Body() SignupRequest signupRequest);

}
