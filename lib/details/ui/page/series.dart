import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marval/details/cubit/series/series_cubit.dart';
import 'package:marval/details/model/series.dart';

import '../../../widgets/state_layout.dart';
import '../widgets/item.dart';

class SeriesPage extends StatefulWidget {
  const SeriesPage({super.key,required this.id});
  final int id;
  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> with AutomaticKeepAliveClientMixin<SeriesPage>, SingleTickerProviderStateMixin{

  final controller = ScrollController();
  bool loading = true;
  List<Series> all = [];
  int offset = 0;
  int _index=-1;

  @override
  void initState() {
    context.read<SeriesCubit>().getSeries(widget.id.toString(), null);
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset && !loading) {
        context.read<SeriesCubit>().getSeries(widget.id.toString(), '&offset=${offset}');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocListener<SeriesCubit, SeriesState>(
      listener: (context, state) {
        state.when(
          initial: () => null, 
          loading: () => setState(() {loading=true;}), 
          success: (series) => setState(() {all+=series;offset+=10;loading=false;print('hhh');}), 
          error: () => setState(() {loading=false;})
        );
      },
      child: all.isEmpty & loading
      ?StateLayout(type: StateType.loading)
      :all.isEmpty & !loading
      ?StateLayout(type: StateType.network,fonction: () => context.read<SeriesCubit>().getSeries(widget.id.toString(),null))
      :ListView.builder(
        controller: controller,
        itemCount: all.length + 1,
        itemBuilder: (context, index) {
          return index < all.length
          ?ItemsWidget(
            title: all[index].title,
            image: '${all[index].thumbnail.path}.${all[index].thumbnail.extension}',
            desc: all[index].description==null ?'' :all[index].description!,
            heroTag: 'SeriesHero$index',
            index: index,
            index2: _index,
            index3: 1,
            onpress: () {setState(() {_index==index?_index=-1:_index=index;});}
          )
          :loading?Center(child: CupertinoActivityIndicator(radius: 16.0)): null;
        }
      ),
    );
  }
  
  @override
  bool get wantKeepAlive => true;
}