import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/providers/conectivity_provider.dart';
import 'package:travel_guard/widgets/history/history_empty_list.dart';
import 'package:travel_guard/widgets/history/history_show_distance.dart';
import 'package:travel_guard/widgets/history/history_show_time.dart';
import 'package:travel_guard/widgets/home/home_bottom_navigation_bar.dart';
import 'package:travel_guard/widgets/home/home_logo_app_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (Provider.of<ConnectivityState>(context, listen: false).getStatus() ==
          false) {
        Navigator.pushNamed(context, '/error', arguments: '/history');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 70),
              color: Color.fromARGB(255, 244, 251, 250),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(user!.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<dynamic> historyList =
                      snapshot.data!.get('history') ?? [];

                  if (historyList.isEmpty) {
                    return EmptyHistoryList();
                  }

                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    height: MediaQuery.of(context).size.height - 200,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: historyList.length,
                      itemBuilder: (context, index) {
                        var historyItem = historyList[index];
                        return Container(
                          margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 14, 35, 32),
                          ),
                          child: ListTile(
                            title: Text(
                              "${historyItem['startingAddress'].toString().split(",")[0]} - ${historyItem['destinationAddress'].toString().split(",")[0]}",
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child:
                                  ShowDistanceWidget(historyItem: historyItem),
                            ),
                            trailing: ShowTimeWidget(
                                historyItem: historyItem, user: user),
                            leading: Icon(
                              Icons.history_edu_outlined,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            HomeLogoAppBar(),
            HomeBottomNavBar(active: 0),
          ],
        ),
      ),
    );
  }
}
