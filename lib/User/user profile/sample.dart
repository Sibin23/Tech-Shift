import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:prosample_1/User/db/db_functions.dart';
import 'package:prosample_1/User/db/user_model.dart';
import 'package:prosample_1/User/user%20profile/add_account.dart';
import 'package:prosample_1/User/user%20profile/update_profile.dart';
import 'package:prosample_1/User/utils/colors.dart';
import 'package:prosample_1/User/utils/commonfile.dart';
import 'package:prosample_1/User/utils/text_decorations.dart';

class SamapleScreen extends StatefulWidget {
  const SamapleScreen({super.key});

  @override
  State<SamapleScreen> createState() => _SamapleScreenState();
}

class _SamapleScreenState extends State<SamapleScreen> {
  // Data persistence (replace with your preferred method)

  @override
  void initState() {
    getUser();
    super.initState();
    
  }

  Future<void> _loadUserData() async {
    // Load user data from persistent storage
final userBox = await Hive.box<UserModel>('userProfile');
  profile.value = userBox.values.toList(); 
    // Update UI depending on data availability
    // ...
  }

  Future<void> _updateUser(int index, UserModel updatedUser) async {
    // Update user data in persistence and UI

    // ...
  }

  void _navigateToEditProfile(int index) {
    // Implement navigation to your edit profile page, passing user data if needed
    Navigator.push(
        context, MaterialPageRoute(builder: (ctx) => const UpdateProfile()));

    void navigateToMyAccount() {
      // Implement navigation to your MyAccount page
      Navigator.push(context,
          MaterialPageRoute(builder: (ctx) => const ScreenMyAccount()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder<List<UserModel>>(
        valueListenable: profile, // Use ValueNotifier for UI updates
        builder: (context, profile, child) {
          if (profile.isEmpty) {
            return Center(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Center(
                      child: Lottie.asset(
                          'assets/Animations/Animation - 1708060808685.json',
                          fit: BoxFit.cover)),
                  
                  const Text('No user profile found. Add user'),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => const ScreenMyAccount()));
                    },
                    style: ElevatedButton.styleFrom(
                        textStyle: TextStyling.subtitle,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColors.appTheme,
                        foregroundColor: Colors.white),
                    child: const Text('Add Profile'),
                  )
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              final user = profile[index];
              return UserCard(
                user: user,
                onUpdate: () => _navigateToEditProfile(index),
              );
            },
          );
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final UserModel user;
  final VoidCallback onUpdate;

  const UserCard({
    super.key,
    required this.user,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Column(
                  children: [
                    // SizedBox(
                    //     width: MediaQuery.of(context).size.width * 0.4,
                    //     height: MediaQuery.of(context).size.height * 0.2,
                    //     child: Image.file(File(user.imagePath!),fit: BoxFit.cover)),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  // Display user information (name, phone number, etc.)
                                  
                                  const Text('Name'),
                                  Text(user.name, style: TextStyling.subtitle3),
                                  const SizedBox(height: 10),
                                  const Text('Mobile No.'),
                                  Text(user.phNum, style: TextStyling.subtitle3),
                                  const SizedBox(height: 10),
                                  const Text('City'),
                                  Text(user.city, style: TextStyling.subtitle3),
                                  const SizedBox(height: 10),
                                  const Text('State'),
                                  Text(user.state, style: TextStyling.subtitle3),
                                  const SizedBox(height: 10),
                                  const Text('Pincode'),
                                  Text(user.pincode, style: TextStyling.subtitle3),
                                  const SizedBox(height: 10),
                                  const Text('House No, Building No..,'),
                                  Text(user.home, style: TextStyling.subtitle3),
                                  const SizedBox(height: 10),
                                  const Text('Road Name, Area..,'),
                                  Text(user.street, style: TextStyling.subtitle3),
                                  const SizedBox(height: 20),
                                  UiHelper.customButton(context, () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => const UpdateProfile()));
                                  }, text: 'Edit Profile')
                                ]),
                  ],
                )));
  }

  
}
