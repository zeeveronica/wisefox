import 'dart:async';
import 'package:wisefox/client/features/bloc/sentedfiles/sentedfiles_bloc.dart';
import 'package:wisefox/client/features/utils/thecolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _MyStudentsState();
}

class _MyStudentsState extends State<Search> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<DemoRequestBloc>().add(FetchSentedfiles());

    _searchController.addListener(_onSearchChanged);

    // Step 2: Request focus when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _focusNode.dispose(); // Dispose the FocusNode
    _debounce?.cancel();

    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(Duration(milliseconds: 500), () {
      context
          .read<DemoRequestBloc>()
          .add(Fetchsearch(searchQuery: _searchController.text));
    });
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff00008B),
        centerTitle: true,
        title: Text(
          "Search",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage("assets/client/images/background3.png"),
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.7),
              BlendMode.colorDodge,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Container(
                height: h * 0.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: theColors.classclr),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: _searchController,
                    focusNode:
                        _focusNode, // Attach the FocusNode to the TextField
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: SvgPicture.asset(
                          "assets/client/images/search.svg",
                          height: 24,
                          width: 24,
                        ),
                      ),
                      hintText: "Search students...",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: BlocConsumer<DemoRequestBloc, DemoRequestState>(
                  listener: (context, state) {
                    if (state is DemoRequestedfilesError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              // Text('Failed to load students: ${state.error}'),
                              Text('Coming Soon'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is DemoRequestedLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is StudentSearchLoaded) {
                      if (state.students.isEmpty) {
                        return Center(
                            child: Text("No students found for your search."));
                      }
                      return ListView.builder(
                        itemCount: state.students.length,
                        itemBuilder: (BuildContext context, int index) {
                          final student = state.students[index];
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: theColors.classclr),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                height: h * 0.13,
                                width: w,
                                padding: EdgeInsets.symmetric(vertical: 1.0),
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 28,
                                      backgroundImage:
                                          NetworkImage(student.studentPhoto)),
                                  title: Text(
                                    "${student.fullName}",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 4),
                                      Text("Active",
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 10)),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("Academic Year:",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10)),
                                          Text(" ${student.year}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10)),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Text("Client:",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 10)),
                                          Text(" ${student.clientUsername}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 10)),
                                        ],
                                      ),
                                    ],
                                  ),
                                  isThreeLine: true,
                                ),
                              ),
                              SizedBox(height: h * 0.02),
                            ],
                          );
                        },
                      );
                    } else if (state is DemoRequestedfilesError) {
                      return Center(
                          child:
                              // Text('Failed to load students: ${state.error}'));
                              Text('Coming Soon'));
                    } else {
                      return Center(child: Text("No Search found"));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
