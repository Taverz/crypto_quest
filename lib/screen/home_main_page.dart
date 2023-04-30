


import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../service/nertwork_service.dart';

class HomePageMain extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenerConnectSnackbar(context, ref);
    return  Scaffold(
      body: Column(
          children: [
            _appBar(),
            _content(),
          ],
        ),
    );
  }

  Widget _appBar(){
    return Container(
      margin:const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          const SizedBox(width: 50,),
          const Spacer(),
          const Text("Главная"),
          const Spacer(),
          SizedBox(
            width: 50,
            child: Center(
              child: IconButton(
                onPressed:(){

                },
                icon: const Icon(Icons.settings),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _content(){
    return Container(
      margin:const EdgeInsets.all(15),
      child:_contentPageList() ,
    );
  }

  Widget _contentPageList(){
    return ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index){
          return Container();
        },
      );
  }

}