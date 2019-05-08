import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart' as kiwi;
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
          }),
    );
  }
}
