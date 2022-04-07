import 'package:bloc/bloc.dart';
import 'package:dining_hall/domain/entities/no_params.dart';
import 'package:dining_hall/domain/entities/user_entity.dart';
import 'package:dining_hall/domain/usecases/user_profile/get_user_detail.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetUserDetail getUserDetail;

  UserProfileBloc(this.getUserDetail) : super(UserProfileInitial()) {
    on<UserProfileLoadEvent>((event, emit) async {
      emit(UserProfileLoading());
      final response = await getUserDetail(NoParams());
      print("IN BLOC");
      print(response.toString());
      emit(response.fold(
          (l) => UserProfileError(), (r) => UserProfileLoaded(r)));
    });
  }
}
