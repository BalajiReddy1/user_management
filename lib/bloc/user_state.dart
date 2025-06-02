// lib/bloc/user_state.dart
import 'package:equatable/equatable.dart';
import '../models/user.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final List<User> users;
  final bool hasReachedMax;

  UserLoaded({required this.users, this.hasReachedMax = false});

  UserLoaded copyWith({
    List<User>? users,
    bool? hasReachedMax,
  }) {
    return UserLoaded(
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [users, hasReachedMax];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}
