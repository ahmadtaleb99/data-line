// import 'package:datalines/presentation/forms/bloc/forms_bloc.dart';
// import 'package:datalines/presentation/resources/values_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// class NodeWidget extends StatelessWidget {
//   const NodeWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FormsBloc, FormsState>(
//       builder: (context, state) {
//         return  Padding(
//           padding: const EdgeInsets.only(right: 11,left: 18.0,top: 10,bottom: 10),
//           child: DecoratedBox(
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.1),
//                 borderRadius:
//                const  BorderRadius.all(Radius.circular(AppRadius.r20)),
//                 border: Border.all(
//                   color: Colors.white,
//                   width: 0.2,
//                 ),
//               ),
//               child: Padding(
//                   padding: const EdgeInsets.all(AppRadius.r10),
//                   child: Center(
//                     child:  DropdownButton<String>(
//
//                       underline: Container(),
//                       value: state.currentNode != null ? state.currentNode!.id : null,
//                       items: state.nodes
//                           .map((e) => DropdownMenuItem<String>(
//                         child: Text(e.name,
//                             style: Theme.of(context).textTheme.subtitle1),
//                         value: e.id,
//                       ))
//                           .toList(),
//                       onChanged: (value) {
//                       },
//                       selectedItemBuilder: (context){
//                         return state.nodes
//                             .map((e) => DropdownMenuItem<String>(
//                           child: Text(e.name,
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   fontStyle: FontStyle.italic,
//                                   color: Colors.white)),
//                           value: e.id,
//                         )).toList();
//                       },
//
//                       icon: const Icon(Icons.arrow_drop_down,color: Colors.white,),
//                     ),
//                   ))),
//         )
//         ;
//       },
//     );
//   }
// }
