import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';

class Vendor {
  final int vendorId;
  final String vendorName;
  final String? ccode;
  final String subRequirementId;

  Vendor({
    required this.vendorId,
    required this.vendorName,
    this.ccode,
    required this.subRequirementId,
  });

  factory Vendor.fromJson(CMDlResponse json, int i) {
    return Vendor(
      vendorId: json.data[i]['Vendor_id'] as int,
      vendorName: json.data[i]['vendor_name'] as String,
      ccode: json.data[i]['ccode'] as String?,
      subRequirementId: json.data[i]['Sub_requirement_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Vendor_id': vendorId,
      'vendor_name': vendorName,
      'ccode': ccode,
      'Sub_requirement_id': subRequirementId,
    };
  }
}

class Processvendor {
  final int vendorId;
  final String vendorName;
  final String vendor_phoneno;
  final String vendor_gstno;

  Processvendor({
    required this.vendorId,
    required this.vendorName,
    required this.vendor_phoneno,
    required this.vendor_gstno,
  });

  factory Processvendor.fromJson(CMDlResponse json, int i) {
    return Processvendor(
      vendorId: json.data[i]['Vendor_id'] as int,
      vendorName: json.data[i]['vendor_name'] as String,
      vendor_phoneno: json.data[i]['vendor_phoneno'] as String,
      vendor_gstno: json.data[i]['vendor_gstno'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Vendor_id': vendorId,
      'vendor_name': vendorName,
      'vendor_phoneno': vendor_phoneno,
      'vendor_gstno': vendor_gstno,
    };
  }
}

class Process {
  final int processid;
  final String title;
  final String vendor_name;
  final String Process_date;
  final int age_in_days;
  final List<TimelineEvent> TimelineEvents;

  Process({
    required this.processid,
    required this.title,
    required this.vendor_name,
    required this.Process_date,
    required this.age_in_days,
    required this.TimelineEvents,
  });

  factory Process.fromJson(CMDlResponse json, int i) {
    String formattedDate = DateFormat("dd MMM yyyy").format(DateTime.parse(json.data[i]['Process_date'] as String));
    return Process(
      processid: json.data[i]['processid'] as int,
      title: json.data[i]['title'] ?? '',
      vendor_name: json.data[i]['vendor_name'] as String,
      Process_date: formattedDate,
      age_in_days: json.data[i]['age_in_days'] as int,
      TimelineEvents: (json.data[i]['TimelineEvents'] as List<dynamic>).map((event) => TimelineEvent.fromJson(event as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'processid': processid,
      'title': title,
      'vendor_name': vendor_name,
      'Process_date': Process_date,
      'age_in_days': age_in_days,
      'TimelineEvents': TimelineEvents,
    };
  }
}

class TimelineEvent {
  final String pdfpath;
  final TextEditingController feedback;
  final String Eventname;
  final int Eventid;
  final int apporvedstatus;
  final int internalStatus;
  final Allowedprocess Allowed_process;

  TimelineEvent({
    required this.pdfpath,
    required this.feedback,
    required this.Eventname,
    required this.Eventid,
    required this.apporvedstatus,
    required this.internalStatus,
    required this.Allowed_process,
  });

  factory TimelineEvent.fromJson(Map<String, dynamic> json) {
    return TimelineEvent(
        pdfpath: json['pdfpath'] as String? ?? '',
        feedback: TextEditingController(text: json['feedback'] as String? ?? ''),
        Eventname: json['Eventname'] as String? ?? '',
        Eventid: json['Eventid'] as int,
        apporvedstatus: json['apporvedstatus'] as int,
        internalStatus: json['internalstatus'] as int,
        Allowed_process: Allowedprocess.fromJson(json['Allowed_process'] != null ? json['Allowed_process'] as Map<String, dynamic> : {}));
  }

  Map<String, dynamic> toJson() {
    return {
      'pdfpath': pdfpath,
      'feedback': feedback,
      'Eventname': Eventname,
      'Eventid': Eventid,
      'apporvedstatus': apporvedstatus,
      'internalstatus': internalStatus,
      'Allowed_process': Allowed_process.toJson(), // Ensure serialization works for Allowed_process
    };
  }
}

class Allowedprocess {
  final bool rfq;
  final bool invoice;
  final bool quotation;
  final bool debit_note;
  final bool credit_note;
  final bool delivery_challan;
  final bool revised_quatation;
  final bool get_approval;
  Allowedprocess({
    required this.rfq,
    required this.invoice,
    required this.quotation,
    required this.debit_note,
    required this.credit_note,
    required this.delivery_challan,
    required this.revised_quatation,
    required this.get_approval,
  });

  factory Allowedprocess.fromJson(Map<String, dynamic> json) {
    return Allowedprocess(
      rfq: json['rfq'] as bool? ?? false,
      invoice: json['invoice'] as bool? ?? false,
      quotation: json['quotation'] as bool? ?? false,
      debit_note: json['debit_note'] as bool? ?? false,
      credit_note: json['credit_note'] as bool? ?? false,
      delivery_challan: json['delivery_challan'] as bool? ?? false,
      revised_quatation: json['revised_quatation'] as bool? ?? false,
      get_approval: json['get_approval'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rfq': rfq,
      'invoice': invoice,
      'quotation': quotation,
      'debit_note': debit_note,
      'credit_note': credit_note,
      'delivery_challan': delivery_challan,
      'revised_quatation': revised_quatation,
      'get_approval': get_approval,
    };
  }
}

class PDFfileData {
  final File data;

  PDFfileData({
    required this.data,
  });

  static Future<File> saveBytesToFile(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory(); // Get temporary directory
    final file = File('${tempDir.path}/temp.pdf'); // Define file path
    await file.writeAsBytes(bytes); // Write bytes to file
    return file;
  }

  static Future<PDFfileData> fromJson(CMDmResponse json) async {
    if (json.data['data'] is List<dynamic>) {
      Uint8List fileBytes = Uint8List.fromList(json.data['data'].cast<int>());
      File file = await saveBytesToFile(fileBytes);
      return PDFfileData(data: file);
    }
    throw TypeError();
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.path, // Convert File to path string for JSON
    };
  }
}

class Vendordata {
  final String? totalamount;
  final String? paidamount;
  final String? unpaidamount;
  final int? totalinvoices;
  final int? paidinvoices;
  final int? unpaidinvoices;

  Vendordata({
    this.totalamount,
    this.paidamount,
    this.unpaidamount,
    this.totalinvoices,
    this.paidinvoices,
    this.unpaidinvoices,
  });

  factory Vendordata.fromJson(CMDmResponse json) {
    return Vendordata(
      totalamount: json.data['totalamount'] as String?,
      paidamount: json.data['paidamount'] as String?,
      unpaidamount: json.data['unpaidamount'] as String?,
      totalinvoices: json.data['totalinvoices'] as int?,
      paidinvoices: json.data['paidinvoices'] as int?,
      unpaidinvoices: json.data['unpaidinvoices'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalamount': totalamount,
      'paidamount': paidamount,
      'unpaidamount': unpaidamount,
      'totalinvoices': totalinvoices,
      'paidinvoices': paidinvoices,
      'unpaidinvoices': unpaidinvoices,
    };
  }
}

class Clientprofiledata {
  final String? vendorname;
  final String? mailid;
  final String? Phonenumber;
  final String? gstnumber;
  final String? clientaddress;
  final String? clientaddressname;
  final String? billingaddress;
  final String? billingaddressname;
  final int? totalprocess;
  final int? inactive_process;
  final int? activeprocess;
  final String? clienttype;
  final int? companycount;
  final int? sitecount;
  Clientprofiledata({
    this.vendorname,
    this.mailid,
    this.Phonenumber,
    this.gstnumber,
    this.clientaddress,
    this.clientaddressname,
    this.billingaddress,
    this.billingaddressname,
    this.totalprocess,
    this.inactive_process,
    this.activeprocess,
    this.clienttype,
    this.companycount,
    this.sitecount,
  });

  factory Clientprofiledata.fromJson(CMDmResponse json) {
    return Clientprofiledata(
      vendorname: json.data['vendorname'] as String?,
      mailid: json.data['mailid'] as String?,
      Phonenumber: json.data['Phonenumber'] as String?,
      gstnumber: json.data['gstnumber'] as String?,
      clientaddress: json.data['clientaddress'] as String?,
      clientaddressname: json.data['clientaddressname'] as String?,
      billingaddress: json.data['billingaddress'] as String?,
      billingaddressname: json.data['billingaddressname'] as String?,
      totalprocess: json.data['totalprocess'] as int?,
      inactive_process: json.data['inactive_process'] as int?,
      activeprocess: json.data['activeprocess'] as int?,
      clienttype: json.data['clienttype'] as String?,
      companycount: json.data['companycount'] as int?,
      sitecount: json.data['sitecount'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vendorname': vendorname,
      'mailid': mailid,
      'Phonenumber': Phonenumber,
      'gstnumber': gstnumber,
      'clientaddress': clientaddress,
      'clientaddressname': clientaddressname,
      'billingaddress': billingaddress,
      'billingaddressname': billingaddressname,
      'totalprocess': totalprocess,
      'inactive_process': inactive_process,
      'activeprocess': activeprocess,
      'clienttype': clienttype,
      'companycount': companycount,
      'sitecount': sitecount,
    };
  }
}

class VendorPDF_List {
  final String vendorAddressName;
  final String vendorAddress;
  final String billingAddress;
  final String billingAddressName;
  final String vendorEmail;
  final String vendorPhone;
  final String vendorGst;
  final String date;
  final String customType;
  final String genId;
  final int customPDFid;
  // final Uint8List pdfData;
  final String filePath;

  VendorPDF_List({
    required this.vendorAddressName,
    required this.vendorAddress,
    required this.billingAddress,
    required this.billingAddressName,
    required this.vendorEmail,
    required this.vendorPhone,
    required this.vendorGst,
    required this.date,
    required this.customType,
    required this.genId,
    required this.customPDFid,
    // required this.pdfData,
    required this.filePath,
  });

  factory VendorPDF_List.fromJson(Map<String, dynamic> json) {
    String formattedDate = DateFormat("dd MMM yyyy").format(DateTime.parse(json['date'] as String));
    return VendorPDF_List(
      vendorAddressName: json['vendoraddress_name'] ?? '',
      vendorAddress: json['vendoraddress'] ?? '',
      billingAddress: json['billing_address'] ?? '',
      billingAddressName: json['billingaddress_name'] ?? '',
      vendorEmail: json['vendor_mailid'] ?? '',
      vendorPhone: json['vendor_phoneno'] ?? '',
      vendorGst: json['vendor_gstno'] ?? '',
      date: formattedDate,
      customType: json['custom_type'] ?? '',
      customPDFid: json['custompdfid'] ?? 0,
      genId: json['gen_id'] ?? '',
      // pdfData: json['pdf_path'] != null && json['pdf_path']['data'] != null ? Uint8List.fromList(List<int>.from(json['pdf_path']['data'])) : Uint8List(0),
      filePath: json['path'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'vendoraddress_name': vendorAddressName,
      'vendoraddress': vendorAddress,
      'billing_address': billingAddress,
      'billingaddress_name': billingAddressName,
      'vendor_mailid': vendorEmail,
      'vendor_phoneno': vendorPhone,
      'vendor_gstno': vendorGst,
      'date': date,
      'custom_type': customType,
      'customPDFid': customPDFid,
      'gen_id': genId,
      // 'pdf_path': {
      //   'type': 'Buffer',
      //   'data': pdfData.toList(),
      // },
      'path': filePath,
    };
  }
}

class ProductSuggestion {
  final String productName;
  final String productHsn;
  final double productPrice;
  final double productGst;

  ProductSuggestion({
    required this.productName,
    required this.productHsn,
    required this.productPrice,
    required this.productGst,
  });

  /// Factory method to convert JSON to Product object
  factory ProductSuggestion.fromJson(Map<String, dynamic> json) {
    return ProductSuggestion(
      productName: json['product_name'] as String,
      productHsn: json['product_hsn'].toString(), // Ensure String type
      productPrice: (json['product_price'] as num).toDouble(),
      productGst: (json['product_gst'] as num).toDouble(),
    );
  }

  /// Method to convert Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'product_name': productName,
      'product_hsn': productHsn,
      'product_price': productPrice,
      'product_gst': productGst,
    };
  }
}
