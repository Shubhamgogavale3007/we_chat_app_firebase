import 'package:flutter/material.dart';

class PopUp extends StatefulWidget {
  const PopUp({super.key});

  @override
  State<PopUp> createState() => _PopUp();
}

class _PopUp extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    radius: 30,
                    child: Icon(
                      Icons.file_copy,
                      color: Colors.white,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 30,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      )),
                  onTap: () {
                    Navigator.pop(context, "camera");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: CircleAvatar(
                      backgroundColor: Colors.pink,
                      radius: 30,
                      child: Icon(
                        Icons.image,
                        color: Colors.white,
                      )),
                  onTap: () {
                    Navigator.pop(context, "gallery");
                  },
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    backgroundColor: Colors.orange,
                    radius: 30,
                    child: Icon(
                      Icons.headphones,
                      color: Colors.white,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 30,
                    child: Icon(
                      Icons.currency_rupee,
                      color: Colors.white,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 30,
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.white,
                      )),
                  onTap: () {
                    Navigator.pop(context, "location");
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
