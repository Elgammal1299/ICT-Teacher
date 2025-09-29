import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:icd_teacher/features/home/data/models/lessons_model.dart';
import 'package:icd_teacher/features/revision/data/repo/revisions_repo.dart';

part 'get_revisions_state.dart';

class GetRevisionsCubit extends Cubit<GetRevisionsState> {
  GetRevisionsCubit(this.repo) : super(GetRevisionsInitial());
    final RevisionsRepo repo;
  Future<void> getRevisions(String termId, contentType) async {
    emit(GetRevisionsLoading());
    final result = await repo.getRevisions(termId, contentType);
    result.fold(
      (failure) => emit(GetRevisionsError(failure.errMessage)),
      (response) => emit(GetRevisionsSuccess(response)),
    );
  }
}
