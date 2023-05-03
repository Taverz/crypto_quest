

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../other/route_app.dart';
import '../service/authorization_service.dart';
import '../service/nertwork_service.dart';

final loginPageProv = Provider((ref) => AuthService());


class RegistrationPageW extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var sizeV =const SizedBox(height: 15,);
    listenerConnectSnackbar(context, ref);
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
            child: const Text(""),
          ),
          TextFieldCustomW(ref.watch(loginPageProv).login ,"Login", (data){
            ref.watch(loginPageProv).login = data;
          },
          ),
          sizeV,
           TextFieldCustomW(ref.watch(loginPageProv).password ,"Password", (data){
            ref.watch(loginPageProv).password = data;
          },
          ),
          TextFieldCustomW(ref.watch(loginPageProv).name ,"name", (data){
            ref.watch(loginPageProv).name = data;
          },
          ),
          Switch(value:ref.watch(loginPageProv).male , onChanged: (val){ref.watch(loginPageProv).male = val;}),
          TextFieldCustomW(ref.watch(loginPageProv).age.toString()  ,"age", (data){
            ref.watch(loginPageProv).age = int.parse(data.isEmpty?"0":data);
          },
          ),
          sizeV,
          //TODO: если письмо не видно провертье в Спам, возможно оно  случано упало туда
          _buttonConfirm(
            (){
              //TODO: interval send
                  ref.watch(loginPageProv).registration(
                    (){
                    print('SUCCESS REQ CONFIRM WERTEGO');
                    // context.go(AppRoutesConst.SPLASH+ AppRoutesConst.LOGIN);
                  },
                  (){
                      //TODO: Dialog errore
                  },
                  );
                  //TODO: bloc butonn start timer from 
            },
          ), 
          SizedBox(height: 40,),

          TextFieldCustomW(ref.watch(loginPageProv).werifyCode ,"name", (data){
            ref.watch(loginPageProv).werifyCode = data;
          },
          ),
          _buttonConfirm(
            (){
                ref.watch(loginPageProv).confirmEmail(
                  success:(){
                    print('SUCCESS REGISTRATION WERTEGO');
                  // context.go(AppRoutesConst.SPLASH+ AppRoutesConst.LOGIN);
                },
                errore:(){

                },
                );
            },
          ),
        ],
        ),
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
  final String initControllerText;
  final Function(String) writetext;
  const TextFieldCustomW(this.initControllerText, this.hint, this.writetext);
   @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text:initControllerText);
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