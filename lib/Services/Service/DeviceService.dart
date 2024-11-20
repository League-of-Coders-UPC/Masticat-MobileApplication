import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../model/Device/Device.dart';

part 'DeviceService.g.dart';

@RestApi(baseUrl: "https://animal-shelter-p65z.onrender.com/api")
abstract class DeviceService {
  factory DeviceService(Dio dio, {String baseUrl}) = _DeviceService;

  // Obtener todos los dispositivos
  @GET("/devices/")
  Future<List<Device>> getDevice();

  @POST("/devices/")
  Future<void> addDevice(@Body() Map<String, dynamic> payload);


  // Actualizar un dispositivo parcialmente
  @PATCH("/devices/{device_id}/")
  Future<Device> patchDevice(
      @Path("device_id") String deviceId,
      @Body() Map<String, dynamic> updateData,
      );

  // Eliminar un dispositivo
  @DELETE("/devices/{device_id}/")
  Future<void> deleteDevice(@Path("device_id") String deviceId);
}
