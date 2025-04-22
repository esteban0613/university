import 'package:flutter/material.dart';
import '../../data/models/university_model.dart';
import '../../data/repositories/university_repository.dart';
import '../widgets/university_card.dart';

class UniversityListScreen extends StatefulWidget {
  @override
  State<UniversityListScreen> createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<UniversityListScreen> {
  final UniversityRepository repository = UniversityRepository();

  final int _itemsPerPage = 20;
  List<UniversityModel> _allUniversities = [];
  List<UniversityModel> _visibleUniversities = [];
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool isGrid = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final universities = await repository.fetchUniversities();
      setState(() {
        _allUniversities = universities;
        _visibleUniversities = _allUniversities.take(_itemsPerPage).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print("Error al cargar universidades: $e");
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        _visibleUniversities.length < _allUniversities.length) {
      _loadMoreItems();
    }
  }

  void _loadMoreItems() {
    setState(() => _isLoadingMore = true);

    Future.delayed(Duration(milliseconds: 500), () {
      final nextItems = _allUniversities
          .skip(_visibleUniversities.length)
          .take(_itemsPerPage)
          .toList();

      setState(() {
        _visibleUniversities.addAll(nextItems);
        _isLoadingMore = false;
      });
    });
  }

  Widget _buildLoadingItem() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Universidades'),
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGrid = !isGrid;
              });
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : isGrid
              ? GridView.builder(
                  controller: _scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  padding: EdgeInsets.all(8),
                  itemCount: _visibleUniversities.length + (_isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _visibleUniversities.length) {
                      return _buildLoadingItem();
                    }
                    return UniversityCard(university: _visibleUniversities[index]);
                  },
                )
              : ListView.builder(
                  controller: _scrollController,
                  itemCount: _visibleUniversities.length + (_isLoadingMore ? 1 : 0),
                  padding: EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    if (index == _visibleUniversities.length) {
                      return _buildLoadingItem();
                    }
                    return UniversityCard(university: _visibleUniversities[index]);
                  },
                ),
    );
  }
}
