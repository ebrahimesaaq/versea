import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:versea/Features/Home/data/cubits/home_cubit/home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitial());
}
