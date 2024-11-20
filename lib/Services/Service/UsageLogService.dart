import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../model/UsageLog.dart';

part 'UsageLogService.g.dart';

@RestApi(baseUrl: "https://animal-shelter-p65z.onrender.com/api")
abstract class UsageLogService {
  factory UsageLogService(Dio dio, {String baseUrl}) = _UsageLogService;

  @GET("/api/usage-logs/")
  Future<List<UsageLog>> getUsageLogs();

  @GET("/api/usage-logs/{id}/")
  Future<UsageLog> getUsageLogById(@Path("id") String id);

  @POST("/api/usage-logs/")
  Future<UsageLog> createUsageLog(@Body() UsageLog usageLog);

  @PUT("/api/usage-logs/{id}/")
  Future<UsageLog> updateUsageLog(@Path("id") String id, @Body() UsageLog usageLog);

  @PATCH("/usage-logs/{id}/")
  Future<UsageLog> patchUsageLog(@Path("id") String id, @Body() Map<String, dynamic> partialUpdate);

  @DELETE("/api/usage-logs/{id}/")
  Future<void> deleteUsageLog(@Path("id") String id);
}
