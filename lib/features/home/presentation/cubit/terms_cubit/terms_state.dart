part of 'terms_cubit.dart';

sealed class TermsState extends Equatable {
  const TermsState();

  @override
  List<Object> get props => [];
}

final class TermsInitial extends TermsState {}
final class TermsLoading extends TermsState {}
final class TermsSuccess extends TermsState {
  final List<TermModel> data;
  const TermsSuccess(this.data);

  @override
  List<Object> get props => [data];
}
final class TermsError extends TermsState {
  final String errMessage;
  const TermsError(this.errMessage);

  @override
  List<Object> get props => [errMessage];
}
