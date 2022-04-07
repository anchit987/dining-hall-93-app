part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}
class UserProfileLoadEvent extends UserProfileEvent {
  
  const UserProfileLoadEvent();

  @override
  List<Object> get props => [];
}
