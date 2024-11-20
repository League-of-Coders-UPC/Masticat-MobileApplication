import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../model/UserData/User.dart';

part 'UserService.g.dart';

@RestApi(baseUrl: "https://animal-shelter-p65z.onrender.com/api")
abstract class UserService {
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  @GET("/api/users/")
  Future<List<User>> getUsers();

  @GET("/api/users/{id}/")
  Future<User> getUserById(@Path("id") String id);

  @POST("/api/users/")
  Future<User> createUser(@Body() User user);

  @PUT("/api/users/{id}/")
  Future<User> updateUser(@Path("id") String id, @Body() User user);

  @PATCH("/users/{id}/")
  Future<User> patchUser(@Path("id") String id, @Body() Map<String, dynamic> partialUpdate);

  @DELETE("/api/users/{id}/")
  Future<void> deleteUser(@Path("id") String id);
}
