import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../model/Device/Device.dart';

part 'DeviceActionService.g.dart';

@RestApi(baseUrl: "https://animal-shelter-p65z.onrender.com/api")
abstract class DeviceActionService {
  factory DeviceActionService(Dio dio, {String baseUrl}) = _DeviceActionService;

  @POST("/update-device-quantity/")
  Future<Device> updateDeviceQuantity(@Body() Map<String, dynamic> payload);
}
