import 'package:bloc/bloc.dart';
import 'package:youtube_search/data/repository/youtube_repository.dart';
import 'package:youtube_search/ui/search/search.dart';
import 'package:youtube_search/data/model/search/youtube_search_error.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final YoutubeRepository _youtubeRepository;

  SearchBloc(this._youtubeRepository) : super();

  void onSearchInitiated(String query) {
    dispatch(SearchInitiated((b) => b..query = query));
  }

  void fetchNextPageResult() {
    dispatch(FetchNextResultPage());
  }

  @override
  SearchState get initialState => SearchState.initial();

  @override
  Stream<SearchState> mapEventToState(
    SearchState currentState,
    SearchEvent event,
  ) async* {
    if (event is SearchInitiated) {
      yield* mapSearchInitiated(event);
    } else if (event is FetchNextResultPage) {
      yield* mapFetchNextResultPage();
    }
  }

  Stream<SearchState> mapSearchInitiated(SearchInitiated event) async* {
    if (event.query.isEmpty) {
      yield SearchState.initial();
    } else {
      yield SearchState.loading();
      try {
        final _searchResult =
            await _youtubeRepository.searchVideos(event.query);
        yield SearchState.success(_searchResult);
      } on YoutubeSearchError catch (e) {
        yield SearchState.failure(e.message);
      } on NoSearchResultsException catch (e) {
        yield SearchState.failure(e.message);
      }
    }
  }

  Stream<SearchState> mapFetchNextResultPage() async* {
    try {
      final _nextPageResults = await _youtubeRepository.fetchNextResultPage();
      yield SearchState.success(currentState.searchResults + _nextPageResults);
    } on NoNextPageTokenException catch (e) {
      yield currentState.rebuild((b) => b..hasReachedEndOfResults = true);
    } on SearchNotInitiatedException catch (e) {
      yield SearchState.failure(e.message);
    } on YoutubeSearchError catch (e) {
      yield SearchState.failure(e.message);
    }
  }
}
