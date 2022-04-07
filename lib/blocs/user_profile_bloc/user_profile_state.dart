part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}

class UserProfileLoading extends UserProfileState {}

class UserProfileError extends UserProfileState {}

class UserProfileLoaded extends UserProfileState {
  final UserEntity userEntity;

  const UserProfileLoaded(this.userEntity);

  @override
  List<Object> get props => [userEntity];
}
