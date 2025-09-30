import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icd_teacher/features/home/data/models/term_model.dart';
import 'package:icd_teacher/features/home/data/repositories/term_repo.dart';

part 'terms_state.dart';

class TermsCubit extends Cubit<TermsState> {
  TermsCubit(this.repo) : super(TermsInitial());
  final TermRepo repo;
  Future<void> getTram() async {
    emit(TermsLoading());
    final result = await repo.getTermRepo();
    result.fold(
      (failure) => emit(TermsError(failure.errMessage)),
      (response) => emit(TermsSuccess(response)),
    );
  }

}
