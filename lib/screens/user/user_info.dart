import 'package:flutter/material.dart';
import 'package:hamd_user/providers/user_info_provider.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInfoProvider>(
      builder: (context, userInfo, child) {
        return userInfo.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          'http://hamd.loko.uz/' + userInfo.userData!.photo!,
                        )),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            userInfo.userData!.name ?? '',
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                            '${userInfo.userData!.phone}   ID: ${userInfo.userData!.id}'),
                        const SizedBox(height: 44),
                      ],
                    ),
                  ],
                ),
              );
      },
    );
  }
}
