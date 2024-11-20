import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../model/Role.dart';

part 'RoleService.g.dart';

@RestApi(baseUrl: "https://animal-shelter-p65z.onrender.com/api")
abstract class RoleService {
  factory RoleService(Dio dio, {String baseUrl}) = _RoleService;

  @GET("/api/roles/")
  Future<List<Role>> getRoles();

  @GET("/api/roles/{id}/")
  Future<Role> getRoleById(@Path("id") String id);

  @POST("/api/roles/")
  Future<Role> createRole(@Body() Role role);

  @PUT("/api/roles/{id}/")
  Future<Role> updateRole(@Path("id") String id, @Body() Role role);

  @PATCH("/roles/{id}/")
  Future<Role> patchRole(@Path("id") String id, @Body() Map<String, dynamic> partialUpdate);

  @DELETE("/api/roles/{id}/")
  Future<void> deleteRole(@Path("id") String id);
}
