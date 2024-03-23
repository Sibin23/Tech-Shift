import 'package:flutter/material.dart';
import 'package:prosample_1/User/Favorites/db/functions.dart';
import 'package:prosample_1/User/Favorites/db/model.dart';

class ScreenProcess extends StatefulWidget {
  const ScreenProcess({super.key});

  @override
  State<ScreenProcess> createState() => _ScreenProcessState();
}

class _ScreenProcessState extends State<ScreenProcess> {
  List<FavModel> favoritesData = [];

  @override
  void initState() {
    super.initState();
    _getFavorites();
  }

  Future<void> _getFavorites() async {
    final data = await DatabaseHelper.instance.getFavs();
    setState(() {
      favoritesData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: FutureBuilder<List<FavModel>>(
        future: DatabaseHelper.instance.getFavs(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final favoritesData = snapshot.data!;
            return SafeArea(
              child: ListView.builder(
                itemCount: favoritesData.length,
                itemBuilder: (context, index) {
                  final fav = favoritesData[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      color: Colors.amber,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Column(
                        children: [
                          Text(fav.name!),
                          Text(fav.oldPrice!),
                          Text(fav.newPrice!),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading favorites'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
