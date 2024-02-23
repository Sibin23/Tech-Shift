import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DropDownScreen extends StatefulWidget {
  final ValueChanged<String> onSocketSelected;
  final ValueChanged<String> onCoresSelected;
  final ValueChanged<String> onThreadsSelected;
  final ValueChanged<String> onSpeedSelected;
  final ValueChanged<String> onProcessorSelected; 
  const DropDownScreen({
    super.key,
    required this.onProcessorSelected,
    required this.onSocketSelected,
    required this.onCoresSelected,
    required this.onThreadsSelected,
    required this.onSpeedSelected,
  });

  @override
  State<DropDownScreen> createState() => _DropDownScreenState();
}

class _DropDownScreenState extends State<DropDownScreen> {
  String? selectedSocket;
  String? selectedCores;
  String? selectedThreads;
  String? selectedSpeed;
  String? selectedProcessor;
  void navigateToSocketScreen(String socket) {}

  void navigateToCoresScreen(String cores) {}
  void navigateToThreadsScreen(String threads) {}

  void navigateToSpeedScreen(String speed) {}
  final cpuname = TextEditingController();
  final core = TextEditingController();
  final socket = TextEditingController();
  final threads = TextEditingController();
  final speed = TextEditingController();
  void _handleProcessorSelected(String value) {
    setState(() {
      selectedProcessor = value;
      widget.onProcessorSelected(value); // Call passed-in function
    });
  }
  void _handleSocketSelected(String value) {
    setState(() {
      selectedSocket = value;
      widget.onSocketSelected(value); // Call passed-in function
    });
  }
  void _handleCorestSelected(String value) {
    setState(() {
      selectedCores = value;
      widget.onCoresSelected(value); // Call passed-in function
    });
  }
  void _handleThreadsSelected(String value) {
    setState(() {
      selectedThreads = value;
      widget.onThreadsSelected(value); // Call passed-in function
    });
  }
  void _handleSpeedSelected(String value){
    setState(() {
      selectedSpeed = value;
      widget.onSpeedSelected(value);
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('cpudetails').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final processor = snapshot.data!.docs
            .map((doc) => doc['name'] as String )
            .toSet()
            .toList();
        final sockets = snapshot.data!.docs
            .map((doc) => doc['socket'] as String)
            .toSet()
            .toList();
        final cores = snapshot.data!.docs
            .map((doc) => doc['cores'] as String)
            .toSet()
            .toList();
        final threads = snapshot.data!.docs
            .map((doc) => doc['threads'] as String)
            .toSet()
            .toList();
        final speeds = snapshot.data!.docs
            .map((doc) => doc['speed'] as String)
            .toSet()
            .toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             DropdownMenu<String>(
              menuStyle: const MenuStyle(
                  surfaceTintColor: MaterialStatePropertyAll(Colors.white)),
              hintText: 'Select Processor',
              // textStyle: CustomText.categoryTitleText,
              width: MediaQuery.of(context).size.width * .93,
              menuHeight: 300,
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  fillColor: Colors.white,
                  filled: true),
              onSelected: (value) {
                setState(() {
                  selectedSocket = value;
                  // widget.onSocketSelected(value!);
                });
              },
              dropdownMenuEntries:
                  processor.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            const SizedBox(height: 10),
            DropdownMenu<String>(
              menuStyle: const MenuStyle(
                  surfaceTintColor: MaterialStatePropertyAll(Colors.white)),
              hintText: 'Select Socket',
              // textStyle: CustomText.categoryTitleText,
              width: MediaQuery.of(context).size.width * .93,
              menuHeight: 300,
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  fillColor: Colors.white,
                  filled: true),
              onSelected: (value) {
                setState(() {
                  selectedSocket = value;
                  widget.onSocketSelected(value!);
                });
              },
              dropdownMenuEntries:
                  sockets.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            const SizedBox(height: 10),
            DropdownMenu<String>(
              menuStyle: const MenuStyle(
                  surfaceTintColor: MaterialStatePropertyAll(Colors.white)),
              hintText: 'Select Cores',
              // textStyle: CustomText.categoryTitleText,
              width: MediaQuery.of(context).size.width * .93,
              menuHeight: 300,
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  fillColor: Colors.white,
                  filled: true),
              onSelected: (value) {
                setState(() {
                  selectedCores = value;
                  widget.onCoresSelected(value!);
                });
              },
              dropdownMenuEntries:
                  cores.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            const SizedBox(height: 10),
            // ... similar dropdowns for threads and speed
            DropdownMenu<String>(
              hintText: 'Select Threads',
              menuStyle: const MenuStyle(
                  surfaceTintColor: MaterialStatePropertyAll(Colors.white)),
              // textStyle: CustomText.categoryTitleText,
              width: MediaQuery.of(context).size.width * .93,
              menuHeight: 300,
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  fillColor: Colors.white,
                  filled: true),
              onSelected: (value) {
                setState(() {
                  selectedThreads = value;
                  widget.onThreadsSelected(value!);
                });
              },
              dropdownMenuEntries:
                  threads.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
            const SizedBox(height: 10),
            DropdownMenu<String>(
              hintText: 'Select Speed',
              menuStyle: const MenuStyle(
                  surfaceTintColor: MaterialStatePropertyAll(Colors.white)),
              // textStyle: CustomText.categoryTitleText,
              width: MediaQuery.of(context).size.width * .93,
              menuHeight: 300,
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
                  fillColor: Colors.white,
                  filled: true),
              onSelected: (value) {
                setState(() {
                  selectedSpeed = value;
                  widget.onSpeedSelected(value!);
                });
              },
              dropdownMenuEntries:
                  speeds.map<DropdownMenuEntry<String>>((String value) {
                return DropdownMenuEntry<String>(value: value, label: value);
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
