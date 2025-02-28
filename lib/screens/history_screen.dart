import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel_guard/models/marker_history.dart';
import 'package:travel_guard/state/conectivity_state.dart';
import 'package:travel_guard/utils/history_utils.dart';
import 'package:travel_guard/widgets/home/bottom_navigation_bar.dart';
import 'package:travel_guard/widgets/home/logo_app_bar.dart';

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
      if (Provider.of<ConnectivityProvider>(context, listen: false).getStatus() == false) {
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
                stream: FirebaseFirestore.instance.collection('users').doc(user!.uid).snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData || !snapshot.data!.exists) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  List<dynamic> historyList = snapshot.data!.get('history') ?? [];
                  if (historyList.isEmpty) {
                    return EmptyHistoryWIdget();
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
                              child: Row(
                                spacing: 10,
                                children: [
                                  Text(
                                    "${HistoryUtils.getDistance(historyItem['distance'])}",
                                    style: GoogleFonts.staatliches(color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    HistoryUtils.timeFromTo(DateTime.parse(historyItem['started']), DateTime.parse(historyItem['finished'])),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(context, '/history_details', arguments: MarkerHistory.fromMap(historyItem));
                                    },
                                    child: Text(
                                      "Details",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: Column(
                              spacing: 10,
                              children: [
                                Text("${DateTime.parse(historyItem['finished']).day}/${DateTime.parse(historyItem['finished']).month}/${DateTime.parse(historyItem['finished']).year}", style: TextStyle(color: Colors.white)),
                                InkWell(
                                  onTap: () {
                                    FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
                                      'history': FieldValue.arrayRemove([
                                        historyItem
                                      ])
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete_forever_outlined,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
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
            LogoAppBar(),
            BottomNavBar(active: 0),
          ],
        ),
      ),
    );
  }
}

class EmptyHistoryWIdget extends StatelessWidget {
  const EmptyHistoryWIdget({
    super.key,
  });
//
//Color.fromARGB(255, 22, 59, 57)
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(bottom: 600),
        width: 320,
        height: 110,
        decoration: BoxDecoration(color: Color.fromARGB(255, 14, 35, 32), borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "No history yet",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              "Your travel history will appear here",
              style: TextStyle(color: Colors.white, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
