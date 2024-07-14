part of 'pagination_builder_cubit.dart';

@immutable
abstract class PaginationBuilderState {}

class PaginationBuilderInitial extends PaginationBuilderState {}

class PaginationBuilderLoading extends PaginationBuilderState {}

class PaginationBuilderPushLogin extends PaginationBuilderState {}

class PaginationBuilderError extends PaginationBuilderState {
  final String errorText;

  PaginationBuilderError({required this.errorText});
}

class PaginationBuilderFetched extends PaginationBuilderState {
  final List<dynamic> listOfValue;

  PaginationBuilderFetched({required this.listOfValue});
}

