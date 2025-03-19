// import 'package:flutter/material.dart';
// import 'package:store/Core/Utils/app_styles.dart';

// class UserInfolisttile extends StatelessWidget {
//   const UserInfolisttile({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: () {},
//       leading: Container(
//         height: 60,
//         width: 60,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: Theme.of(context).cardColor,
//           border: Border.all(
//             color: Theme.of(context).colorScheme.surface,
//             width: 2,
//           ),
//           image: const DecorationImage(
//             image: NetworkImage(''),
//           ),
//         ),
//       ),
//       title: Text(
//         getUser().name,
//         style: AppStyles.styleMedium20,
//       ),
//       subtitle: Text(
//         getUser().email,
//         style: AppStyles.styleRegular16,
//       ),
//     );
//   }
// }
