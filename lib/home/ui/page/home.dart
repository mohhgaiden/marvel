import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marval/details/ui/page/details.dart';
import 'package:marval/home/model/chars.dart';
import 'package:marval/widgets/state_layout.dart';
import '../../cubit/chars_cubit.dart';
import '../widget/item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final controller = ScrollController();
  int _index=-1;
  bool loading = true;

  List<Chars> all = [];
  int offset = 0;

  @override
  void initState() {
    context.read<CharsCubit>().getChars(null);
    controller.addListener(() { 
      if(controller.position.maxScrollExtent == controller.offset && (offset+10)<1546 && !loading){
        context.read<CharsCubit>().getChars('&offset=${offset}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CharsCubit, CharsState>(
        listener: (context, state) {
          state.when(
            initial: () => null, 
            loading: () => setState(() {loading=true;}), 
            success: (chars) => setState(() {all+=chars;offset+=10;loading=false;}), 
            error: () => setState(() {loading=false;})
          );
        },
        child: all.isEmpty & loading
        ?StateLayout(type: StateType.loading)
        :all.isEmpty & !loading
        ?StateLayout(type: StateType.network,fonction: () => context.read<CharsCubit>().getChars(null))
        :Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(children: [
              Text('${all.length}/1546 loaded',style: Theme.of(context).textTheme.titleSmall),
            ])
          ),
          Expanded(child: ListView.builder(
            controller: controller,
            itemCount: all.length+1,
            itemBuilder: (context, index) {
              return index<all.length
              ?GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: all[index].id,name: all[index].name,image: '${all[index].thumbnail.path}.jpg'))),
                child: ItemWidget(
                  id: all[index].id,
                  name: all[index].name,
                  image: '${all[index].thumbnail.path}.jpg',
                  date: all[index].modified,
                  desc: all[index].description,
                  index: index,
                  index2: _index,
                  onpress: () {setState(() {_index==index?_index=-1:_index=index;});},
                ),
              )
              :Center(child: CupertinoActivityIndicator(radius: 16.0));
            }
          ))
        ])
      )
    );
  }
}

