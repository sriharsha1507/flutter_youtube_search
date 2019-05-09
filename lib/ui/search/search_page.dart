import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
import 'package:youtube_search/data/model/detail/model_detail.dart';
import 'package:youtube_search/data/model/search/search_snippet.dart';
import 'package:youtube_search/ui/detail/detail_page.dart';
import 'package:youtube_search/ui/search/search.dart';
import 'package:youtube_search/ui/search/search_bloc.dart';
import 'package:youtube_search/ui/search/widget/centered_message.dart';
import 'package:youtube_search/ui/search/widget/search_bar.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchBloc = kiwi.Container().resolve<SearchBloc>();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(bloc: _searchBloc, child: _buildScaffold());
  }

  @override
  void dispose() {
    super.dispose();
    _searchBloc.dispose();
  }

  Scaffold _buildScaffold() {
    return Scaffold(
      appBar: AppBar(title: SearchBar()),
      body: BlocBuilder(
          bloc: _searchBloc,
          builder: (context, SearchState state) {
            if (state.isInitiated) {
              return CenteredMessage(
                message: 'Start searching',
                icon: Icons.ondemand_video,
              );
            }
            if (state.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state.isSuccessful) {
              return _buildResultList(state);
            } else {
              return CenteredMessage(
                  message: state.error, icon: Icons.error_outline);
            }
          }),
    );
  }

  Widget _buildResultList(SearchState state) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.builder(
        itemCount: _calculateListItemCount(state),
        controller: _scrollController,
        itemBuilder: (context, index) {
          return index >= state.searchResults.length
              ? _buildLoaderListItem()
              : _buildVideoListItem(state.searchResults[index]);
        },
      ),
    );
  }

  int _calculateListItemCount(SearchState state) {
    if (state.hasReachedEndOfResults) {
      return state.searchResults.length;
    } else {
      return state.searchResults.length + 1;
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      _searchBloc.fetchNextPageResult();
    }
    return false;
  }

  Widget _buildLoaderListItem() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildVideoListItem(SearchItem searchItem) {
    return GestureDetector(
      child: _buildVideoListItemCard(searchItem.snippet),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return DetailPage(videoId: searchItem.id.videoId);
        }));
      },
    );
  }

  Widget _buildVideoListItemCard(SearchSnippet videoSnippet) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: <Widget>[
            AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  videoSnippet.thumbnails.high.url,
                  fit: BoxFit.cover,
                )),
            SizedBox(
              height: 5,
            ),
            Text(videoSnippet.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                )),
            SizedBox(
              height: 5,
            ),
            Text(videoSnippet.description)
          ],
        ),
      ),
    );
  }
}
