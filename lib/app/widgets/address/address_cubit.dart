import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:perso/core/dependency_injection/get_it.dart';
import 'package:perso/data/address_provider/google_address_provider.dart';

@injectable
class AddressCubit extends Cubit<List<String>> {
  AddressCubit() : super([]);
  final _addressProvider = getIt.get<GoogleAddressProvider>();

  Future<List<String>> fetchAddressSuggestions(String input) async {
    final suggestions = await _addressProvider.fetchAddressSuggestions(input);
    return suggestions;
  }
}
