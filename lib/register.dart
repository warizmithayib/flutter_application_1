import 'package:flutter/material.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  var statusCheckbox = false;
  var statustextInvisible = true;

  @override
  Widget build(BuildContext context) {
    print("times loop build");
    return Scaffold(
      body: ListView(
        children: [
          TextFormField(
            obscureText: statustextInvisible,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                onTap: () {
                  statustextInvisible = !statustextInvisible;
                  setState(() {});
                },
                child: const Icon(Icons.remove_red_eye),
              ),
            ),
          ),
          Checkbox(
              value: statusCheckbox,
              onChanged: (isChecked) {
                if (statusCheckbox == false) {
                  statusCheckbox = true;
                } else {
                  statusCheckbox = false;
                }
                //statusCheckbox = isChecked;
                //statusCheckbox = !statusCheckbox;
                setState(() {});
              }),
        ],
      ),
    );
  }
}
