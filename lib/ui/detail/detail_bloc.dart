import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:youtube_search/data/model/detail/youtube_video_error.dart';
import 'package:youtube_search/data/repository/youtube_repository.dart';
import 'package:youtube_search/ui/detail/detail_event.dart';
import 'package:youtube_search/ui/detail/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  YoutubeRepository repository;

  DetailBloc(this.repository);

  void onShowDetail({@required String id}) {
    dispatch(ShowDetail((b) => b..id = id));
  }

  @override
  DetailState get initialState => DetailState.initial();

  @override
  Stream<DetailState> mapEventToState(
    DetailState state,
    DetailEvent event,
  ) async* {
    if (event is ShowDetail) {
      yield DetailState.loading()

      try{
        final videoItem = await repository.fetchVideoInfo(id: event.id);
        yield DetailState.success(videoItem);
      } on YoutubeVideoError catch(e){
        yield DetailState.failure(e.message);
      }on NoSuchVideoException catch(e){
        yield DetailState.failure(e.message);
      }
    }
  }
}
