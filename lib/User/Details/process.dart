import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:prosample_1/User/Details/db/user_model.dart';

class ScreenProcess extends StatefulWidget {
  const ScreenProcess({super.key});

  @override
  State<ScreenProcess> createState() => _ScreenProcessState();
}

class _ScreenProcessState extends State<ScreenProcess> {
  List<UserModel> _favorites = []; // List to store favorite items

  @override
  void initState() {
    super.initState();
    _getFavorites(); // Fetch favorites on page load
  }

  Future<void> _getFavorites() async {
    final box = await Hive.box<UserModel>('userBox');
    _favorites = box.values.toList();
    // Update isFavorite based on IDs in the box (optional)
    _favorites.forEach((favorite) => isFavoriteMap[favorite.id] = true);
    setState(() {}); // Update UI with fetched favorites
  }

  // Map to track favorite state for each item (optional)
  final Map<String, bool> isFavoriteMap = {};

  Future<void> _saveToHive(String id, UserModel favorite) async {
    try {
      final box = await Hive.openBox<UserModel>('userBox');
      await box.put(id, favorite); // Use ID as unique key
      isFavoriteMap[id] = true;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item added to Favorites'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e); // Handle errors appropriately
    }
  }

  Future<void> _removeFromFavorites(String id) async {
    try {
      final box = await Hive.openBox<UserModel>('userBox');
      await box.delete(id);
      isFavoriteMap.remove(id);
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Item Deleted'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print(e); // Handle errors appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: _favorites.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                final favorite = _favorites[index];
                final isFavorited =
                    isFavoriteMap[favorite.id] ?? false; // Check map for state
                // Display each favorite item using favorite.id, name, etc.
                return ListTile(
                  title: Text(favorite.name),
                  trailing: IconButton(
                    icon: Icon(
                      isFavorited
                          ? Icons.favorite
                          : Icons.favorite_border_outlined,
                      color: isFavorited ? Colors.red : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _removeFromFavorites(favorite.id);
                      });
                    }
                  ),
                  // ... (add other widgets for display)
                );
              },
            ),
    );
  }

//   void _toggleFavorite(String id, data) {
//     final isFavorited = isFavoriteMap[id] ?? false;
//     if (isFavorited) {
//       _removeFromFavorites(id);
//     } else {
//       // Assuming you have a way to retrieve UserModel based on Firebase ID
//       final data = id;
//       if (data != null) {
//         _saveToHive(id, data);
//       }
//     }
//   }
}
