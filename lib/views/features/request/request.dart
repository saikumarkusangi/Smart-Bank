import 'package:bank/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/widgets.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  
  @override
  Widget build(BuildContext context) {
    
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      
      backgroundColor: ThemeColors.secondary,
      appBar: AppBar(
        iconTheme:const IconThemeData(color: Colors.black,size: 32),
        backgroundColor: ThemeColors.yellow,
        elevation: 0,
        //title:const Text('Request money to',style: TextStyle(color: ThemeColors.primary),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                SizedBox(
                  
                  height: 100,
                  child: Column(
                    children: [
                      const  Text('Request money to',style: TextStyle(color: ThemeColors.primary,fontSize: 28,fontWeight: FontWeight.bold),),
                     Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:const [
                      
                      Text('',style: TextStyle(
                        color: Colors.black,
                        fontSize: 28
                      ),),
                     
                    ],
                   )])),
                  
                
                  
                    Padding(
                      padding:  EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.2),
                      child: SizedBox(
                      
                        height: MediaQuery.of(context).size.height / 2.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(height: 40,),
                            TextFormField(
                             
                             autofocus: true,
                             keyboardType: TextInputType.number,
                             cursorColor: Colors.black87,
                             style:const TextStyle(
                               decoration: TextDecoration.none,
                               fontWeight: FontWeight.bold,fontSize: 62,),
                              decoration:const InputDecoration(
                               focusedBorder: InputBorder.none,
                               enabledBorder: InputBorder.none,
                                prefix:  Text('₹',style: TextStyle(fontSize: 62,fontWeight: FontWeight.bold),),
                              
                               border: InputBorder.none,
                               
                               hintText: '0',
                               hintStyle: TextStyle(fontSize: 62,fontWeight: FontWeight.bold)
                              ),
                             
                            ),
                          ],
                        ),
                      ),
                    ),
                    MaterialButton(onPressed: (){
                    
                    },
                    color: ThemeColors.yellow,
                                 child:Text('Request',style: TextStyle(color: Colors.black,fontSize: 28),),
                    minWidth: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    )
              ],
                  ),
            ),
          ),
        )),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:
            Visibility(visible: !keyboardIsOpen, child: const Mic()),
    );
  }
}