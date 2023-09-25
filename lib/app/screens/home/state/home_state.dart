import 'package:freezed_annotation/freezed_annotation.dart';
part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = Initial;
  const factory HomeState.navigateToSignIn() = NavigateToSignIn;
  const factory HomeState.navigateToClientDetails() = NavigateToClientDetails;
  const factory HomeState.navigateToTrainerDetails() = NaviagteToTrainerDetails;
}
