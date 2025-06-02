// lib/bloc/user_event.dart
import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// To load initial and paginated user list
class FetchUsers extends UserEvent {
  final int limit;
  final int skip;

  // Optionally, a search query could be included
  final String? searchQuery;

  FetchUsers({this.limit = 10, this.skip = 0, this.searchQuery});

  @override
  List<Object?> get props => [limit, skip, searchQuery ?? ''];
}

// For a pull-to-refresh or search functionality
class SearchUsers extends UserEvent {
  final String searchQuery;

  SearchUsers(this.searchQuery);

  @override
  List<Object?> get props => [searchQuery];
}
