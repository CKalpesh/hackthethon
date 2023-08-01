// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HackathonDataFetched extends HomeState {
  final List<HackathonListModel> hackathons;
  final HackathonDataModel? selectedHackathon;
  const HackathonDataFetched({
    required this.hackathons,
    this.selectedHackathon,
  });

  HackathonDataFetched copyWith({
    List<HackathonListModel>? hackathons,
    HackathonDataModel? selectedHackathon,
  }) {
    return HackathonDataFetched(
      hackathons: hackathons ?? this.hackathons,
      selectedHackathon: selectedHackathon ?? this.selectedHackathon,
    );
  }
}

class HackathonDataFetching extends HomeState {}

class HackathonDataFetchError extends HomeState {}
