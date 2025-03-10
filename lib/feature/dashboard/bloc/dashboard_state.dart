part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  const DashboardState({this.categories = const []});

  final List<Category> categories;

  @override
  List<Object> get props => [categories];

  DashboardState copyWith({List<Category>? categories}) {
    return DashboardState(categories: categories ?? this.categories);
  }
}
