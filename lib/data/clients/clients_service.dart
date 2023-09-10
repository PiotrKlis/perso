import 'package:Perso/app/models/client_data.dart';

abstract class ClientsService {
  Future<void> uploadData(ClientData clientData);
  Future<void> uploadPhoto(String path);
}
