part of 'get_content_by_id_cubit.dart';

sealed class GetContentByIdState extends Equatable {
  const GetContentByIdState();

  @override
  List<Object> get props => [];
}

final class GetcontentByIdInitial extends GetContentByIdState {}

final class GetContentByIdLoading extends GetContentByIdState {}

final class GetContentByIdSuccess extends GetContentByIdState {
  final  ContentModel contentModel;
  const GetContentByIdSuccess(this.contentModel);
}
final class GetContentByIdError extends GetContentByIdState {
  final String errMessage;
  const GetContentByIdError(this.errMessage);
}