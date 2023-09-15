import 'package:flutter/material.dart';

class ThemeDialog extends StatefulWidget {
  const ThemeDialog({super.key});

  @override
  State<ThemeDialog> createState() => _ThemeDialogState();
}

class _ThemeDialogState extends State<ThemeDialog> {
  bool isLight = false;
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: const BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          height: 60,
          width: double.infinity,
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Choose theme",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'DMSans',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Checkbox(
                        shape: const CircleBorder(),
                        side: const BorderSide(
                            color: Colors.deepPurple, width: 1),
                        activeColor: Colors.deepPurple,
                        value: isLight,
                        onChanged: (value) {
                          setState(() {
                            isLight = !isLight;
                            if (isLight == true) {
                              setState(() {
                                isDark = false;
                              });
                            }
                            isLight = true;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Light ",
                    style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 1.4,
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: Checkbox(
                        shape: const CircleBorder(),
                        side: const BorderSide(
                            color: Colors.deepPurple, width: 1),
                        activeColor: Colors.deepPurple,
                        value: isDark,
                        onChanged: (value) {
                          setState(() {
                            isDark = !isDark;
                            if (isDark == true) {
                              setState(() {
                                isLight = false;
                              });
                            }
                            isDark = true;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Text(
                    "Dark ",
                    style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    child: const Text('Cancel',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  InkWell(
                    child: const Text('OK',
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontFamily: 'DMSans',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                    onTap: () {
                      /*     if(isLight ){
                        Get.back();
                        Get.changeTheme(changeTheme().light);

                      }else{
                        Get.back();
                        Get.changeTheme(changeTheme().dark);
                      }*/
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}
