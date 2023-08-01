import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hack_the_thon/screens/cubit/home/home_cubit.dart';
import 'package:hack_the_thon/screens/home_screen/hackathon_description.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getAllHackathon(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'All Hackathons',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HackathonDataFetched) {
              return ListView.separated(
                itemCount: state.hackathons.length,
                itemBuilder: (context, index) {
                  final hackathon = state.hackathons.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HackathonDescriptionScreen(
                            id: hackathon.sId!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                hackathon.name ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              subtitle: Text(
                                hackathon.venue ?? r'N/A',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Colors.black54,
                                ),
                              ),
                              trailing: Text(
                                hackathon.theme ?? '',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                            Row(
                              children: [
                                ListRow(
                                  title: 'Start Date:',
                                  subtitle: hackathon.startDate ?? 'N/A',
                                ),
                                const Spacer(),
                                ListRow(
                                  title: 'End Date:',
                                  subtitle: hackathon.endDate ?? 'N/A',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                ListRow(
                                  title: 'Opens:',
                                  subtitle: hackathon.applicationOpen ?? 'N/A',
                                ),
                                const Spacer(),
                                ListRow(
                                  title: 'Deadline',
                                  subtitle:
                                      hackathon.applicationDeadline ?? 'N/A',
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 20,
                  );
                },
              );
            } else if (state is HackathonDataFetching) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HackathonDataFetchError) {
              return const Center(
                child: Text(
                  'Something Went Wrong',
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class ListRow extends StatelessWidget {
  const ListRow({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          subtitle,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
