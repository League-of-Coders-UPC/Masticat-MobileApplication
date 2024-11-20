import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../model/Habitos/Habit.dart';

part 'HabitService.g.dart';

@RestApi(baseUrl: "https://animal-shelter-p65z.onrender.com/api")
abstract class HabitService {
  factory HabitService(Dio dio, {String baseUrl}) = _HabitService;

  @GET("/api/habits/")
  Future<List<Habit>> getHabits();

  @GET("/api/habits/{id}/")
  Future<Habit> getHabitById(@Path("id") String id);

  @POST("/api/habits/")
  Future<Habit> createHabit(@Body() Habit habit);

  @PUT("/api/habits/{id}/")
  Future<Habit> updateHabit(@Path("id") String id, @Body() Habit habit);

  @PATCH("/habits/{id}/")
  Future<Habit> patchHabit(@Path("id") String id, @Body() Map<String, dynamic> partialUpdate);

  @DELETE("/api/habits/{id}/")
  Future<void> deleteHabit(@Path("id") String id);
}
