import 'package:christmas_form/model/hex_color.dart';
import 'package:christmas_form/model/user.dart';
import 'package:christmas_form/widget/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserFormWidget extends StatefulWidget {
  final ValueChanged<User> onSavedUser;

  const UserFormWidget({
    Key? key,
    required this.onSavedUser,
  }) : super(key: key);

  @override
  _UserFormWidgetState createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
    final Color red = HexColor("#AA3A38");
  final Color green = HexColor("#2F7336");


  late String dateNow = DateFormat("dd-MM-yyyy hh:mm:ss").format(DateTime.now());
  
  final formKey = GlobalKey<FormState>();
  late TextEditingController controllerName;
  late TextEditingController controllerEmail;
  late TextEditingController controllerDegree;
  late TextEditingController controllerPhone;
  late TextEditingController controllerFb;

  @override
  void initState() {
    super.initState();

    initUser();
  }

  void initUser() {
    controllerName = TextEditingController();
    controllerEmail = TextEditingController();
    controllerDegree = TextEditingController();
    controllerPhone = TextEditingController();
    controllerFb = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  red,
                  green,
                  // Color(0xFF25565108),
                  // Color(0x6b107229133),
                ]),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(50),
          width: 700,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildName(),
              const SizedBox(height: 16),
              buildEmail(),
              const SizedBox(height: 16),
              buildDegree(),
              const SizedBox(height: 16),
              buildPhone(),
              const SizedBox(height: 16),
              buildFb(),
              const SizedBox(height: 16),
              buildSubmit(),
            ],
          ),
        ),
      );

  Widget buildName() => TextFormField(
        controller: controllerName,
        decoration: const InputDecoration(
          labelText: 'H??? V?? T??n',
          labelStyle: TextStyle(color: Colors.white),
          // curs: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
        ),
        validator: (value) => value != null && value.isEmpty ? 'Ch??a nh???p h??? v?? t??n nhen!!!' : null,
      );

  Widget buildEmail() => TextFormField(
        controller: controllerEmail,
        decoration: const InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          )
        ),
        validator: (value) => value != null && !value.contains('@') ? 'Ch??a nh???p Email n??!!!' : null,
      );

  Widget buildDegree() => TextFormField(
        controller: controllerDegree,
        decoration: const InputDecoration(
          labelText: 'B???n ??ang l?? kh??a m???y? (v?? d???: K17)',
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          )
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Ch??a nh???p kh??a n??!!!' : null,
      );

  Widget buildPhone() => TextFormField(
        controller: controllerPhone,
        decoration: const InputDecoration(
          labelText: 'S??? ??i???n tho???i',
          labelStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          )
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Ch??a nh???p s??? ??i???n tho???i n??!!!' : null,
      );

  Widget buildFb() => TextFormField(
        controller: controllerFb,
        decoration: const InputDecoration(
          labelText: 'Link Facebook (https://...)',
           labelStyle: TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          )
        ),
        validator: (value) =>
            value != null && !value.contains('https://') ? 'Ch??a nh???p Link Facebook n??!!!' : null,
      );

  Widget buildSubmit() => ButtonWidget(
        text: '????ng K??',
        onClicked: () {
          final form = formKey.currentState!;
          final isValid = form.validate();
          
          if (isValid) {
            final user = User(
              name: controllerName.text,
              email: controllerEmail.text,
              degree: controllerDegree.text,
              phone: controllerPhone.text,
              fb: controllerFb.text,
              date: dateNow,
            );
            widget.onSavedUser(user);
            formKey.currentState?.reset();
          }
          // formKey.currentState?.reset();
        },
      );
}
