

// class ProjectUtils{
// textformfield(
//       {required icon,
//       required controller,
//       required obsecure,
//       required focusedcolor,
//       required enabled,
//       required iconcolor}) {
//     return TextFormField(
//       cursorColor: ProjectUtils().textformfieldcolor,
//       cursorWidth: 3,
//       style: TextStyle(
//         fontWeight: FontWeight.bold,
//         color: ProjectUtils().textformfieldcolor,
//       ),
//       controller: controller,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please Fill This Field !';
//         } else {
//           return null;
//         }
//       },
//       decoration: InputDecoration(
//         disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               width: 3,
//               color: ProjectUtils().textformfieldcolor,
//             ),
//             borderRadius: BorderRadius.circular(100)),
//         enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(width: 3, color: enabled),
//             borderRadius: BorderRadius.circular(100)),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
//         errorBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//               width: 2,
//               color: Color.fromARGB(255, 225, 15, 0),
//             ),
//             borderRadius: BorderRadius.circular(100)),
//         focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(
//               width: 3,
//               color: focusedcolor,
//             ),
//             borderRadius: BorderRadius.circular(100)),
//         prefixIcon: Icon(
//           icon,
//           size: 23,
//           color: iconcolor,
//         ),
//       ),
//       obscureText: obsecure,
//     );
//   }

// }

