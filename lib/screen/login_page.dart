

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../service/nertwork_service.dart';

final loginPageProv = Provider((ref) => LoginPageProvider());

class LoginPageProvider  {
  String? login;
  String? password;
  auth(){
    //TODO: validation
    
  }
}

class LoginPageW extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var sizeV =const SizedBox(height: 15,);
    listenerConnectSnackbar(context, ref);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        TextFieldCustomW("Login", (data){
          ref.watch(loginPageProv).login = data;
        },
        ),
        sizeV,
         TextFieldCustomW("Password", (data){
          ref.watch(loginPageProv).password = data;
        },
        ),
        sizeV,
        _buttonConfirm((){ref.watch(loginPageProv).auth();}),
      ],
      ),
    );
  }
  Widget _buttonConfirm(Function onTapp){
    return InkWell(
      radius: 12,
      onTap: (){onTapp();},
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child:const Text("Confirm"),
      ),
    );
  }

}

class TextFieldCustomW extends  HookConsumerWidget{
  final String hint;
  final Function(String) writetext;
  const TextFieldCustomW(this.hint, this.writetext);
   @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    controller.addListener(() {
      writetext(controller.text);
    });

    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border:const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), ),
          hintText: hint,
        ),
      )
    );
  }
}