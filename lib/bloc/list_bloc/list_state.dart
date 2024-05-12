part of 'list_bloc.dart';

@immutable
abstract class ListState extends Equatable {}

class ListLoadingState extends ListState {
  @override
  List<Welcome> get props => [];
}

class ListLoadedState extends ListState {
  final List<Welcome> list;
  ListLoadedState(this.list);
  @override
  List<Welcome> get props => list;
}

class ListErrorState extends ListState {
  final String error;
  ListErrorState(this.error);
  @override
  List<Welcome> get props => [];
}
// @immutable
// sealed class ListState {}

// final class ListInitial extends ListState {}
