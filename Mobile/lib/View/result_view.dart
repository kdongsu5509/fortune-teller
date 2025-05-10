
import 'dart:developer';

import 'package:flutter/material.dart';
import '../ViewModel/result_view_model.dart';

class ResultView extends StatefulWidget {
  const ResultView({Key? key}) : super(key: key);

  @override
  _FaceAnalyzeResultViewState createState() => _FaceAnalyzeResultViewState();
}

class _FaceAnalyzeResultViewState extends State<ResultView> {
  late final ResultViewModel _viewModel;
  StringBuffer _result = StringBuffer();

  @override
  void initState() {
    performAnalysis();
    log("ResultView: initState - 6");
    super.initState();
  }

  void performAnalysis() async {
    _viewModel = ResultViewModel();
    log("ResultView: before initState - 5");
    await _viewModel.loadFaceData(); // 분석 결과 불러오기
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: Text("결과"),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * 0.05,
          MediaQuery.of(context).size.width * 0.02,
          MediaQuery.of(context).size.width * 0.05,
          MediaQuery.of(context).size.width * 0.01,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.025),
                          child: Container(
                            width : MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: StreamBuilder<String>(
                          stream: _viewModel.resultStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator(
                                color: Colors.black54,
                              ));
                            } else if (snapshot.hasData) {
                              _result.write(snapshot.data);
                              return SingleChildScrollView(child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                                child: Text(_result.toString() ?? "", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)),
                              ));
                            } else {
                              return SingleChildScrollView(child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.025),
                                child: Text(_result.toString(), style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05)),
                              ));
                            }
                          },
                        ),
                      ),
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}