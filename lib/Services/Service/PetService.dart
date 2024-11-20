import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../model/Pet/Pet.dart';

part 'PetService.g.dart';

@RestApi(baseUrl: "https://animal-shelter-p65z.onrender.com/api")
abstract class PetService {
  factory PetService(Dio dio, {String baseUrl}) = _PetService;

  // Obtener todas las mascotas
  @GET("/pets/")
  Future<List<Pet>> getPets();

  // Obtener detalles de una mascota específica
  /*@GET("/pets/{id}/")
  Future<Pet> getPetById(
      @Path("id") String petId, // ID de la mascota
      @Query("user_id") String userId, // user_id como parámetro de consulta
      );
  */

  // Actualización parcial de una mascota
  @PATCH("/pets/{id}/")
  Future<Pet> patchPet(
      @Path("id") String petId, // ID de la mascota
      @Query("user_id") String userId, // user_id como parámetro de consulta
      @Body() Map<String, dynamic> partialUpdate, // Campos a actualizar
      );

  // Eliminación de una mascota
  @DELETE("/pets/{id}/")
  Future<void> deletePet(
      @Path("id") String petId, // ID de la mascota
      @Query("user_id") String userId, // user_id como parámetro de consulta
      );

  // Agregar una nueva mascota
  @POST("/pets/")
  Future<Pet> addPet(
      @Body() Map<String, dynamic> petData, // Datos de la mascota a agregar
      );
}
