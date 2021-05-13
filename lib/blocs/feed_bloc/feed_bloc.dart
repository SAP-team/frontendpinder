
import 'package:bloc/bloc.dart';
import 'package:pinder/halpers/api.dart';

import 'feed_events.dart';
import 'feed_states.dart';

class FeedBloc extends Bloc<FeedEvents, FeedStates> {
  FeedBloc() : super(Loading());

  @override
  Stream<FeedStates> mapEventToState(FeedEvents event) async* {
   if(event is GetFeed) yield* getfeed();
  }

  Stream<FeedStates> getfeed() async* {
    try { 
      Api api = new Api();
      final result = await api.getfeed();
      if(!result["isscuses"]){
                yield Error(result["result"]);

      }else{
                yield Succses(result["result"]);

      }
    } on Exception catch (e) {
      print('error is: ${e.toString()}');
      yield Error("");
    }
  }
}