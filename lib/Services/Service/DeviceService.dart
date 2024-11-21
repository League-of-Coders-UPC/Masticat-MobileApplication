import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../model/Device/Device.dart';

part 'DeviceService.g.dart';

@RestApi(baseUrl: "https://animal-shelter-p65z.onrender.com/api")
abstract class DeviceService {
  factory DeviceService(Dio dio, {String baseUrl}) = _DeviceService;



  @GET("/devices/")
  Future<List<Device>> getUserDeviceByQuery(@Query("user_id") String userId);

  @POST("/devices/")
  Future<void> addDevice(@Body() Map<String, dynamic> payload);


  @PATCH("/devices/{device_id}/")
  Future<Device> patchDevice(
      @Path("device_id") String deviceId,
      @Body() Map<String, dynamic> updateData,
      );

  @DELETE("/devices/{device_id}/")
  Future<void> deleteDevice(@Path("device_id") String deviceId);

  @GET("/devices/{device_id}/")
  Future<Device> getDeviceById(@Path("device_id") String deviceId);


}
