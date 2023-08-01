import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_the_thon/models/hackathon_data_model.dart';
import 'package:hack_the_thon/models/hackathon_list_model.dart';
import 'package:http/http.dart' as http;
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit()
      : super(
          HackathonDataFetching(),
        );

  Future<void> getAllHackathon() async {
    final uri = Uri.parse('$baseUrl/hackathons');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final decodedResponse = await jsonDecode(response.body);
      List<HackathonListModel> hackathons = [];
      for (final hackathon in decodedResponse) {
        hackathons.add(HackathonListModel.fromJson(hackathon));
      }
      emit(
        HackathonDataFetched(
          hackathons: hackathons,
        ),
      );
    }
  }

  Future<void> getIndividualHackathonData(String id) async {
    final uri = Uri.parse('$baseUrl/hackathons/$id');
    final response = await http.get(uri);
    if (state is HackathonDataFetched) {
      final fetchedState = state as HackathonDataFetched;
      emit(
        fetchedState.copyWith(
          selectedHackathon: null,
        ),
      );
      if (response.statusCode == 200) {
        final decodedResponse = await jsonDecode(response.body);
        final hackathonData = HackathonDataModel.fromJson(decodedResponse);

        emit(
          fetchedState.copyWith(selectedHackathon: hackathonData),
        );
      }
    }
  }

  final baseUrl = 'https://bronze-jay-wear.cyclic.app/api';
}
