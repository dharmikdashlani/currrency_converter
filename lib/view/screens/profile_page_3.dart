import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_changer_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20,),
                    child: const Text("Theme Changer",style: TextStyle(fontSize: 25),),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Switch(
                    inactiveTrackColor: (Provider.of<ThemeController>(context,
                        listen: true)
                        .t
                        .isDark)
                        ? Colors.deepOrange
                        : Colors.greenAccent,
                    activeColor: (Provider.of<ThemeController>(context,
                        listen: true)
                        .t
                        .isDark)
                        ? Colors.deepOrange
                        : Colors.greenAccent,
                    value: Provider.of<ThemeController>(context).t.isDark,
                    onChanged: (Val) {
                      Provider.of<ThemeController>(context, listen: false)
                          .setDark();
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 3,
          ),
        ],
      ),
    );
  }
}
