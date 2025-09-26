part of 'answers_submit_cubit.dart';

sealed class AnswersSubmitState extends Equatable {
  const AnswersSubmitState();

  @override
  List<Object> get props => [];
}

final class AnswersSubmitInitial extends AnswersSubmitState {}

final class AnswersSubmitLoading extends AnswersSubmitState {}

final class AnswersSubmitSuccess extends AnswersSubmitState {
  final AnswersQuestionsModel contentModel;
  const AnswersSubmitSuccess(this.contentModel);
}

final class AnswersSubmitError extends AnswersSubmitState {
  final String errMessage;
  const AnswersSubmitError(this.errMessage);
}
