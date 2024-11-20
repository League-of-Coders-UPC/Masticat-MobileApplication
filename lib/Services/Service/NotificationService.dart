import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../model/Notificaciones/Notification.dart';

part 'NotificationService.g.dart';

@RestApi(baseUrl: "https://animal-shelter-p65z.onrender.com/api")
abstract class NotificationService {
  factory NotificationService(Dio dio, {String baseUrl}) = _NotificationService;

  @GET("/api/notifications/")
  Future<List<Notification>> getNotifications();

  @GET("/api/notifications/{id}/")
  Future<Notification> getNotificationById(@Path("id") String id);

  @POST("/api/notifications/")
  Future<Notification> createNotification(@Body() Notification notification);

  @PUT("/api/notifications/{id}/")
  Future<Notification> updateNotification(@Path("id") String id, @Body() Notification notification);

  @PATCH("/notifications/{id}/")
  Future<Notification> patchNotification(@Path("id") String id, @Body() Map<String, dynamic> partialUpdate);

  @DELETE("/api/notifications/{id}/")
  Future<void> deleteNotification(@Path("id") String id);
}
