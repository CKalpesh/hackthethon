// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hack_the_thon/models/hackathon_data_model.dart';
import 'package:hack_the_thon/screens/home_screen/home_screen.dart';
import 'package:http/http.dart' as http;

class HackathonDescriptionScreen extends StatelessWidget {
  const HackathonDescriptionScreen({required this.id, super.key});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder(
          future: getHackathon(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            // if (snapshot.data == null) {
            //   return Center(
            //     child: Text(
            //       snapshot.error.toString(),
            //     ),
            //   );
            // }
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (data.imageUrl != null) Image.network(data.imageUrl!),
                    Center(
                      child: Text(
                        data.name ?? '',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (data.winners != null && data.winners!.isNotEmpty) ...[
                      Divider(),
                      Center(
                        child: Text(
                          'WINNER',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ...List.generate(
                        data.winners!.length,
                        (index) => Center(
                          child: Text(
                            data.winners![index].name ?? '',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                    Divider(),
                    // Information
                    Text(
                      'Information',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    ListRow(
                      title: 'Venue',
                      subtitle: data.venue ?? '',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListRow(
                          title: 'Starting On',
                          subtitle: data.startDate ?? 'N/A',
                        ),
                        ListRow(
                          title: 'Ends On',
                          subtitle: data.endDate ?? 'N/A',
                        ),
                      ],
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListRow(
                          title: 'Max Team Size',
                          subtitle: '${data.maxTeamSize ?? 'N/A'}',
                        ),
                        ListRow(
                          title: 'Min Team Size',
                          subtitle: '${data.minTeamSize ?? 'N/A'}',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Applications
                    Divider(),
                    Text(
                      'Applications',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ListRow(
                          title: 'Start On',
                          subtitle: data.applicationOpen ?? 'N/A',
                        ),
                        ListRow(
                          title: 'Deadline',
                          subtitle: data.applicationDeadline ?? 'N/A',
                        ),
                      ],
                    ),
                    Text(
                      'Prizes',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.purpleAccent,
                      ),
                    ),
                    ...List.generate(
                      data.prizes != null && data.prizes!.isNotEmpty
                          ? data.prizes!.length
                          : 0,
                      (index) => Text.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: data.prizes?.elementAt(index).name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: '${data.prizes?.elementAt(index).amount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ]),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Divider(),
                    Text(
                      'Judges',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    ListView.builder(
                      itemCount: data.judges != null && data.judges!.isNotEmpty
                          ? data.judges!.length
                          : 0,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Text(
                          '\u2022 ${data.judges?.elementAt(index).firstName} ${data.judges?.elementAt(index).lastName}',
                        );
                      },
                    ),
                    Divider(),
                    Text(
                      'Admins',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),

                    Text(
                      '\u2022 ${data.admin?.firstName} ${data.admin?.lastName}',
                    ),

                    // Partneers
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: ExpansionTile(
                        title: Text(
                          'Partners',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 100,
                              crossAxisSpacing: 20,
                            ),
                            itemCount: data.partners != null &&
                                    data.partners!.isNotEmpty
                                ? data.partners!.length
                                : 0,
                            itemBuilder: ((context, index) {
                              final partner = data.partners?.elementAt(index);
                              return Card(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        partner?.name ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        partner?.website ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    // Teams
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: ExpansionTile(
                        title: Text(
                          'Teams',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 100,
                              crossAxisSpacing: 20,
                            ),
                            itemCount:
                                data.teams != null && data.teams!.isNotEmpty
                                    ? data.teams!.length
                                    : 0,
                            itemBuilder: ((context, index) {
                              final team = data.teams!.elementAt(index);
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            team.name ?? 'N/A',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        ...List.generate(team.members!.length,
                                            (index) {
                                          return Text(
                                            '\u2022 ${team.members!.elementAt(index).firstName} ${team.members!.elementAt(index).lastName}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          );
                                        })
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    // FAQs
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: ExpansionTile(
                        title: Text(
                          'FAQs',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount:
                                data.faqs != null && data.faqs!.isNotEmpty
                                    ? data.faqs!.length
                                    : 0,
                            itemBuilder: (context, index) {
                              final faq = data.faqs!.elementAt(index);
                              return ListTile(
                                title: Text(
                                  faq.question ?? '',
                                ),
                                subtitle: Text(
                                  faq.answer ?? '',
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                    // Announcements
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      child: ExpansionTile(
                        title: Text(
                          'Announcements',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.announcements != null &&
                                    data.announcements!.isNotEmpty
                                ? data.announcements!.length
                                : 0,
                            itemBuilder: (context, index) {
                              final announcement =
                                  data.announcements!.elementAt(index);
                              return ListTile(
                                title: Text(
                                  announcement.title ?? 'N/A',
                                ),
                                subtitle: Text(
                                  announcement.description ?? 'N/A',
                                ),
                                trailing: Text(announcement.time ?? ''),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Future<HackathonDataModel?> getHackathon() async {
    try {
      final uri =
          Uri.parse('https://bronze-jay-wear.cyclic.app/api/hackathon/$id');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final decodedResponse = await jsonDecode(response.body);
        final hackathonData = HackathonDataModel.fromJson(decodedResponse);
        return hackathonData;
      }
      return null;
    } catch (e, stackTrace) {
      print('MESSAGE : ${e.toString()}');
      print('STACKTRACE : ${stackTrace}');
    }
  }
}
