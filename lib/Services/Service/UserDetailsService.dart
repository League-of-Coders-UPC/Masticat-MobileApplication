import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../model/UserData/UserDetails.dart';

part 'UserDetailsService.g.dart';

@RestApi(baseUrl: "https://animal-shelter-p65z.onrender.com/api")
abstract class UserDetailsService {
  factory UserDetailsService(Dio dio, {String baseUrl}) = _UserDetailsService;

  @GET("/user-details")
  Future<List<UserDetails>> getUserDetailsByQuery(@Query("user_id") String userId);

  @PATCH("/user-details/{id}/")
  Future<UserDetails> patchUserDetail(
      @Path("id") String id,
      @Body() Map<String, dynamic> partialUpdate
      );


  @DELETE("/user-details/{id}/")
  Future<void> deleteUserDetail(@Path("id") String id);
}
