import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

// ignore: must_be_immutable
class DetailPdf extends StatefulWidget {
  String? fileUrl;

  DetailPdf(this.fileUrl);

  @override
  _DetailPdfState createState() => _DetailPdfState(fileUrl!);
}

class _DetailPdfState extends State<DetailPdf> {
  bool _isLoading = true;
  late PDFDocument _pdf;
  String fileUrl;

  _DetailPdfState(this.fileUrl);

  void _loadFile() async {
    // Load the pdf file from the internet
    _pdf = await PDFDocument.fromURL(fileUrl);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter PDF viewer'),
        backgroundColor: Colors.white,
      ),
      body: Center(
          child: _isLoading == true
              ? Center(child: CircularProgressIndicator())
              : PDFViewer(document: _pdf)),
    );
  }
}
