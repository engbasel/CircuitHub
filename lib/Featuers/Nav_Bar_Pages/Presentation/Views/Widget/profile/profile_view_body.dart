// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:store/Core/Utils/my_app_method.dart';
// import 'package:store/Core/Utils/show_dialog.dart';
// import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/general.dart';
// import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/general_custom_list_tile.dart';
// import 'package:store/Core/Utils/app_styles.dart';
// import 'package:store/Core/Utils/assets.dart';

// import 'package:store/Featuers/authUseingProvider/login.dart';
// import 'package:store/Featuers/authUseingProvider/user_model.dart';
// import 'package:store/providers/theme_provider.dart';
// import 'package:store/providers/user_provider.dart';

// class ProfileViewBody extends StatefulWidget {
//   const ProfileViewBody({super.key});

//   @override
//   State<ProfileViewBody> createState() => _ProfileViewBodyState();
// }

// class _ProfileViewBodyState extends State<ProfileViewBody> {
//   User? user = FirebaseAuth.instance.currentUser;

//   UserModelProvider? userModelProvider;
//   bool isLoading = true;
//   Future<void> fetchUserInfo() async {
//     if (user == null) {
//       setState(() {
//         isLoading = false;
//       });
//       return;
//     }

//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     try {
//       userModelProvider = await userProvider.fetchUserInfo();
//     } catch (error) {
//       if (!mounted) return;
//       await MyAppMethods.showErrorORWarningDialog(
//         context: context,
//         subtitle: "An error has been occured $error",
//         fct: () {},
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     fetchUserInfo();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);

//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20),
//             Visibility(
//               visible: user == null ? true : false,
//               child: const Padding(
//                 padding: EdgeInsets.all(20.0),
//                 child: Text("Please login to have ultimate access"),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             userModelProvider == null
//                 ? const SizedBox.shrink()
//                 : Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                     child: Row(
//                       children: [
//                         Container(
//                           height: 60,
//                           width: 60,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Theme.of(context).cardColor,
//                             border: Border.all(width: 3),
//                             image: DecorationImage(
//                               image: NetworkImage(
//                                 userModelProvider!.userImage,
//                               ),
//                               fit: BoxFit.fill,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(
//                           width: 7,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(userModelProvider!.userName),
//                             Text(
//                               userModelProvider!.userEmail,
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//             // user == null
//             //     ? const Visibility(
//             //         visible: true,
//             //         child: Text(
//             //           'Please Login to have ultimate access',
//             //           style: AppStyles.styleMedium18,
//             //         ),
//             //       )
//             //     : UserInfoListTile(uid: user!.uid),
//             const SizedBox(height: 16),
//             const General(),
//             const SizedBox(height: 16),
//             const Divider(height: 2),
//             const SizedBox(height: 16),
//             const Text(
//               'Settings',
//               style: AppStyles.styleSemiBold18,
//             ),
//             SwitchListTile(
//               secondary: Image.asset(
//                 Assets.users_imagesProfileTheme,
//                 height: 30,
//               ),
//               title: Text(
//                   themeProvider.getIsDarkTheme ? "Dark mode" : "Light mode"),
//               value: themeProvider.getIsDarkTheme,
//               onChanged: (value) {
//                 themeProvider.setDarkTheme(themeValue: value);
//               },
//             ),
//             const SizedBox(height: 16),
//             const Divider(height: 2),
//             const SizedBox(height: 16),
//             const Text(
//               'Others',
//               style: AppStyles.styleSemiBold18,
//             ),
//             GeneralCustomListTile(
//               onTap: () {},
//               image: Assets.users_imagesProfilePrivacy,
//               title: "Privacy & Policy",
//             ),
//             const SizedBox(height: 30),
//             Center(
//               child: ElevatedButton.icon(
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 icon: Icon(user == null ? Icons.login : Icons.logout),
//                 label: Text(user == null ? 'LogIn' : 'Logout'),
//                 onPressed: () async {
//                   if (user == null) {
//                     // Navigate immediately, without using context after an async gap
//                     await Navigator.pushNamed(context, LoginScreen.routeName);
//                   } else {
//                     await ShowDialogClass.showDialogClass(
//                       context: context,
//                       text: 'Are you sure?',
//                       function: () async {
//                         await FirebaseAuth.instance.signOut();
//                         setState(() {});
//                         // Ensure navigation occurs within the addPostFrameCallback
//                         WidgetsBinding.instance.addPostFrameCallback((_) {
//                           Navigator.pushNamed(context, LoginScreen.routeName);
//                         });
//                       },
//                       isError: false,
//                     );
//                   }
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/Core/Utils/my_app_method.dart';
import 'package:store/Core/Utils/show_dialog.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/general.dart';
import 'package:store/Featuers/Nav_Bar_Pages/Presentation/Views/Widget/profile/general_custom_list_tile.dart';
import 'package:store/Core/Utils/app_styles.dart';
import 'package:store/Core/Utils/assets.dart';

import 'package:store/Featuers/authUseingProvider/login.dart';
import 'package:store/Featuers/authUseingProvider/user_info_list_tile.dart';
import 'package:store/Featuers/authUseingProvider/user_model.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/providers/user_provider.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModelProvider? userModelProvider;
  bool isLoading = true;

  Future<void> fetchUserInfo() async {
    if (user == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      userModelProvider = await userProvider.fetchUserInfo();
    } catch (error) {
      if (!mounted) return;
      await MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "An error occurred: $error",
        fct: () {},
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    fetchUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user == null)
              const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("Please log in to have full access.",
                    style: AppStyles.styleSemiBold18),
              ),
            const SizedBox(height: 20),
            if (userModelProvider != null)
              Row(
                children: [
                  Expanded(
                    child: UserInfoListTile(
                      uid: user!.uid,
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 16),
            const General(),
            const SizedBox(height: 16),
            const Divider(height: 2),
            const SizedBox(height: 16),
            const Text(
              'Settings',
              style: AppStyles.styleSemiBold18,
            ),
            SwitchListTile(
              secondary: Image.asset(
                Assets.users_imagesProfileTheme,
                height: 30,
              ),
              title: Text(
                  themeProvider.getIsDarkTheme ? "Dark mode" : "Light mode"),
              value: themeProvider.getIsDarkTheme,
              onChanged: (value) {
                themeProvider.setDarkTheme(themeValue: value);
              },
            ),
            const SizedBox(height: 16),
            const Divider(height: 2),
            const SizedBox(height: 16),
            const Text(
              'Others',
              style: AppStyles.styleSemiBold18,
            ),
            GeneralCustomListTile(
              onTap: () {},
              image: Assets.users_imagesProfilePrivacy,
              title: "Privacy & Policy",
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                icon: Icon(user == null ? Icons.login : Icons.logout),
                label: Text(user == null ? 'LogIn' : 'Logout'),
                onPressed: () async {
                  if (user == null) {
                    await Navigator.pushNamed(context, LoginScreen.routeName);
                  } else {
                    await ShowDialogClass.showDialogClass(
                      context: context,
                      text: 'Are you sure you want to logout?',
                      function: () async {
                        await FirebaseAuth.instance.signOut();
                        setState(() {});
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        });
                      },
                      isError: false,
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
