import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/home/data/models/content_model.dart';
import 'package:icd_teacher/features/home/data/repositories/getcontent_by_id_repo.dart';

part 'get_content_by_id_state.dart';

class GetContentByIdCubit extends Cubit<GetContentByIdState> {
  GetContentByIdCubit(this.repo) : super(GetcontentByIdInitial());
  final GetcontentByIdRepo repo;
  Future<void> getLesson(String termId) async {
    emit(GetContentByIdLoading());
    final result = await repo.getcontentById(termId);
    result.fold(
      (failure) => emit(GetContentByIdError(failure.errMessage)),
      (response) => emit(GetContentByIdSuccess(response)),
    );
  }
}
