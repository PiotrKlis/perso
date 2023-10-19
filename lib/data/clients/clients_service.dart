import 'package:perso/app/models/editable_client_data.dart';

abstract class ClientsService {
  Future<void> uploadData(EditableClientData clientData);
}
