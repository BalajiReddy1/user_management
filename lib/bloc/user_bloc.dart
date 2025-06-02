// lib/bloc/user_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user.dart';
import '../repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;
  static const int fetchLimit = 10;

  UserBloc(this.repository) : super(UserLoading()) {
    on<FetchUsers>(_onFetchUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  Future<void> _onFetchUsers(FetchUsers event, Emitter<UserState> emit) async {
    try {
      // If we already have some users loaded, then we’re appending the next page
      final currentState = state;
      List<User> users = [];
      if (currentState is UserLoaded && event.skip > 0) {
        users = currentState.users;
      }

      final newUsers = await repository.fetchUsers(
        limit: event.limit,
        skip: event.skip,
        searchQuery: event.searchQuery,
      );

      // Check if more users are available for infinite scrolling
      final hasReachedMax = newUsers.length < fetchLimit;

      // Emit loaded state
      emit(UserLoaded(users: users + newUsers, hasReachedMax: hasReachedMax));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> _onSearchUsers(SearchUsers event, Emitter<UserState> emit) async {
    try {
      emit(UserLoading());
      final users = await repository.fetchUsers(
        limit: fetchLimit,
        skip: 0,
        searchQuery: event.searchQuery,
      );
      final hasReachedMax = users.length < fetchLimit;
      emit(UserLoaded(users: users, hasReachedMax: hasReachedMax));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }
}
