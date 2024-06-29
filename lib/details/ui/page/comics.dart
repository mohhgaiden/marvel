import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marval/details/model/comics.dart';
import '../../../widgets/state_layout.dart';
import '../../cubit/comics/comics_cubit.dart';
import '../widgets/item.dart';

class ComicsPage extends StatefulWidget {
  const ComicsPage({super.key, required this.id});
  final int id;
  @override
  State<ComicsPage> createState() => _ComicsPageState();
}

class _ComicsPageState extends State<ComicsPage> with AutomaticKeepAliveClientMixin<ComicsPage>, SingleTickerProviderStateMixin{
  final controller = ScrollController();
  bool loading = true;
  List<Comics> all = [];
  int offset = 0;
  int _index=-1;

  @override
  void initState() {
    context.read<ComicsCubit>().getComics(widget.id.toString(), null);
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset && !loading) {
        context.read<ComicsCubit>().getComics(widget.id.toString(), '&offset=${offset}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<ComicsCubit, ComicsState>(
      listener: (context, state) {
        state.when(
          initial: () => null, 
          loading: () => setState(() {loading=true;}), 
          success: (comics) => setState(() {all+=comics;offset+=10;loading=false;}), 
          error: () => setState(() {loading=false;})
        );
      },
      child: all.isEmpty & loading
      ?StateLayout(type: StateType.loading)
      :all.isEmpty & !loading
      ?StateLayout(type: StateType.network,fonction: () => context.read<ComicsCubit>().getComics(widget.id.toString(),null))
      :ListView.builder(
        controller: controller,
        itemCount: all.length+1,
        itemBuilder: (context, index) {
          return index < all.length
          ?ItemsWidget(
            title: all[index].title,
            image: '${all[index].thumbnail.path}.${all[index].thumbnail.extension}',
            desc: all[index].description==null ?'' :all[index].description!,
            heroTag: 'Hero$index',
            index: index,
            index2: _index,
            index3: 0,
            onpress: () {setState(() {_index==index?_index=-1:_index=index;});}
          )
          :loading?Center(child: CupertinoActivityIndicator(radius: 16.0)): null;
        }
      )
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}
