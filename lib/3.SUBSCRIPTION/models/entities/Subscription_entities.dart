import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ssipl_billing/COMPONENTS-/Response_entities.dart';
/// This class represents a customer in the process of subscription management.
/// It includes properties like customer ID, name, phone number, and GST number.
/// It provides methods to create an instance from JSON and to convert the object to JSON.
class Processcustomer {
  final int customerId;
  final String customerName;
  final String customer_phoneno;
  final String customer_gstno;

  Processcustomer({
    required this.customerId,
    required this.customerName,
    required this.customer_phoneno,
    required this.customer_gstno,
  });

  factory Processcustomer.fromJson(CMDlResponse json, int i) {
    return Processcustomer(
      customerId: json.data[i]['customer_id'] as int,
      customerName: json.data[i]['customer_name'] as String,
      customer_phoneno: json.data[i]['customer_phoneno'] as String,
      customer_gstno: json.data[i]['customer_gstno'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Customer_id': customerId,
      'customer_name': customerName,
      'customer_phoneno': customer_phoneno,
      'customer_gstno': customer_gstno,
    };
  }
}
/// This class represents a recurred customer in the subscription management system.
/// It includes properties like customer ID, name, phone number, and GST number.
/// It provides methods to create an instance from JSON and to convert the object to JSON.
class Recurredcustomer {
  final int customerId;
  final String customerName;
  final String customer_phoneno;
  final String customer_gstno;

  Recurredcustomer({
    required this.customerId,
    required this.customerName,
    required this.customer_phoneno,
    required this.customer_gstno,
  });

  factory Recurredcustomer.fromJson(CMDlResponse json, int i) {
    return Recurredcustomer(
      customerId: json.data[i]['customer_id'] as int,
      customerName: json.data[i]['customer_name'] as String,
      customer_phoneno: json.data[i]['customer_phoneno'] as String,
      customer_gstno: json.data[i]['customer_gstno'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Customer_id': customerId,
      'customer_name': customerName,
      'customer_phoneno': customer_phoneno,
      'customer_gstno': customer_gstno,
    };
  }
}
/// This class represents a process in the subscription management system.
/// It includes properties like process ID, title, customer name, process date, age in days, and a list of timeline events.
/// /// It provides methods to create an instance from JSON and to convert the object to JSON.
class Process {
  final int processid;
  final String title;
  final String customer_name;
  final String Process_date;
  final int age_in_days;
  final List<TimelineEvent> TimelineEvents;
  Process({
    required this.processid,
    required this.title,
    required this.customer_name,
    required this.Process_date,
    required this.age_in_days,
    required this.TimelineEvents,
  });

  factory Process.fromJson(CMDlResponse json, int i) {
    String formattedDate = DateFormat("dd MMM yyyy").format(DateTime.parse(json.data[i]['Process_date'] as String));
    return Process(
      processid: json.data[i]['processid'] as int,
      title: json.data[i]['title'] ?? '',
      customer_name: json.data[i]['customer_name'] as String,
      Process_date: formattedDate,
      age_in_days: json.data[i]['age_in_days'] as int,
      TimelineEvents: (json.data[i]['TimelineEvents'] as List<dynamic>).map((event) => TimelineEvent.fromJson(event as Map<String, dynamic>)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'processid': processid,
      'title': title,
      'customer_name': customer_name,
      'Process_date': Process_date,
      'age_in_days': age_in_days,
      'TimelineEvents': TimelineEvents,
    };
  }
}
/// This class represents a process in the subscription management system.
/// It includes properties like PDF path, feedback, Event name, Event id, apporved status, internal Status and Allowed process.
/// It provides methods to create an instance from JSON and to convert the object to JSON.
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
/// This class represents a process in the subscription management system.
/// It includes properties like Quotation, Revised quotation and Get approval and Allowed process.
/// It provides methods to create an instance from JSON and to convert the object to JSON.
class Allowedprocess {
  final bool quotation;
  final bool revised_quatation;
  final bool get_approval;
  Allowedprocess({
    required this.quotation,
    required this.revised_quatation,
    required this.get_approval,
  });

  factory Allowedprocess.fromJson(Map<String, dynamic> json) {
    return Allowedprocess(
      quotation: json['quotation'] as bool? ?? false,
      revised_quatation: json['revised_quatation'] as bool? ?? false,
      get_approval: json['get_approval'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quotation': quotation,
      'revised_quatation': revised_quatation,
      'get_approval': get_approval,
    };
  }
}

/// This class represents a process in the subscription management system.
/// It includes properties like data.
/// It provides methods to create an instance from JSON and to convert the object to JSON.
class PDFfileData {
  final File data;

  PDFfileData({
    required this.data,
  });

  static Future<File> saveBytesToFile(Uint8List bytes) async {
    final tempDir = await getTemporaryDirectory(); // Get temporary directory
    final file = File('${tempDir.path}/file.pdf'); // Define file path
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
/// This class represents a process in the subscription management system.
/// It includes properties like Total amount,Paid amount,Unpaid amount,Total invoices,Paid invoices and Unpaid invoices.
/// It provides methods to create an instance from JSON and to convert the object to JSON.
class Subscriptiondata {
  final String? totalamount;
  final String? paidamount;
  final String? unpaidamount;
  final int? totalinvoices;
  final int? paidinvoices;
  final int? unpaidinvoices;

  Subscriptiondata({
    this.totalamount,
    this.paidamount,
    this.unpaidamount,
    this.totalinvoices,
    this.paidinvoices,
    this.unpaidinvoices,
  });

  factory Subscriptiondata.fromJson(CMDmResponse json) {
    return Subscriptiondata(
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
/// This class represents a process in the subscription management system.
/// It includes properties like customer name,mail id,Phone number,gst number,client address,client address name,billing address, billing address name,total process,inactive process,active process,client type,company count and site count.
/// It provides methods to create an instance from JSON and to convert the object to JSON.

class Clientprofiledata {
  final String? customername;
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
    this.customername,
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
      customername: json.data['customername'] as String?,
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
      'customername': customername,
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
/// This class represents a process in the subscription management system.
/// It includes properties like customer Address Name,customer Address,billing Address,customer Email,customer Phone,customer Gst,date,custom Type,genId,custom PDF id and file Path .
/// It provides methods to create an instance from JSON and to convert the object to JSON.

class CustomerPDF_List {
  final String customerAddressName;
  final String customerAddress;
  final String billingAddress;
  final String billingAddressName;
  final String customerEmail;
  final String customerPhone;
  final String customerGst;
  final DateTime date;
  final String customType;
  final String genId;
  final int customPDFid;
  // final Uint8List pdfData;
  final String filePath;

  CustomerPDF_List({
    required this.customerAddressName,
    required this.customerAddress,
    required this.billingAddress,
    required this.billingAddressName,
    required this.customerEmail,
    required this.customerPhone,
    required this.customerGst,
    required this.date,
    required this.customType,
    required this.genId,
    required this.customPDFid,
    // required this.pdfData,
    required this.filePath,
  });

  factory CustomerPDF_List.fromJson(Map<String, dynamic> json) {
    return CustomerPDF_List(
      customerAddressName: json['Client_addressname'] ?? '',
      customerAddress: json['client_address'] ?? '',
      billingAddress: json['Billing_address'] ?? '',
      billingAddressName: json['Billing_addressname'] ?? '',
      customerEmail: json['customer_mailid'] ?? '',
      customerPhone: json['customer_phoneno'] ?? '',
      customerGst: json['gstnumber'] ?? '',
      date: DateTime.parse(json['date']),
      customType: json['custom_type'] ?? '',
      customPDFid: json['custompdfid'] ?? 0,
      genId: json['subscription_billid'] ?? '',
      // pdfData: json['pdf_path'] != null && json['pdf_path']['data'] != null ? Uint8List.fromList(List<int>.from(json['pdf_path']['data'])) : Uint8List(0),
      filePath: json['pdfpath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Client_addressname': customerAddressName,
      'client_address': customerAddress,
      'Billing_address': billingAddress,
      'Billing_addressname': billingAddressName,
      'customer_mailid': customerEmail,
      'customer_phoneno': customerPhone,
      'gstnumber': customerGst,
      'date': date.toIso8601String(),
      'custom_type': customType,
      'custombill_id': customPDFid,
      'subscription_billid': genId,
      // 'pdf_path': {
      //   'type': 'Buffer',
      //   'data': pdfData.toList(),
      // },
      'pdfpath': filePath,
    };
  }
}
/// This class represents a process in the subscription management system.
/// It includes properties like customer Address Name,customer Address,billing Address,customer Email,customer Phone,customer Gst,date,custom Type,genId,custom PDF id and file Path .
/// It provides methods to create an instance from JSON and to convert the object to JSON.
class RecurringInvoice_List {
  int recurredbillid;
  int subscriptionBillId;
  List<int> siteIds;
  String clientAddressName;
  String clientAddress;
  String billingAddressName;
  String billingAddress;
  // final Uint8List pdfData;
  String pdfPathString;
  String invoiceNo;
  int totalAmount;
  String emailId;
  String phoneNo;
  String ccEmail;
  String date;

  RecurringInvoice_List({
    required this.recurredbillid,
    required this.subscriptionBillId,
    required this.siteIds,
    required this.clientAddressName,
    required this.clientAddress,
    required this.billingAddressName,
    required this.billingAddress,
    // required this.pdfData,
    required this.pdfPathString,
    required this.invoiceNo,
    required this.totalAmount,
    required this.emailId,
    required this.phoneNo,
    required this.ccEmail,
    required this.date,
  });

  factory RecurringInvoice_List.fromJson(Map<String, dynamic> json) {
    String formattedDate = DateFormat("dd MMM yyyy").format(DateTime.parse(json['date'] as String));
    return RecurringInvoice_List(
      recurredbillid: json['recurredbillid'],
      subscriptionBillId: json['subscription_billid'],
      siteIds: List<int>.from(json['site_Ids'] ?? []),
      clientAddressName: json['client_addressname'].toString(),
      clientAddress: json['client_address'],
      billingAddressName: json['billing_addressname'],
      billingAddress: json['billing_address'],
      // pdfData: json['pdf_data'] != null && json['pdf_data']['data'] != null ? Uint8List.fromList(List<int>.from(json['pdf_data']['data'])) : Uint8List(0),
      pdfPathString: json['pdfpath'],
      invoiceNo: json['Invoice_no'],
      totalAmount: json['TotalAmount'],
      emailId: json['email_id'],
      phoneNo: json['phone_no'].toString(),
      ccEmail: json['ccemail'],
      date: formattedDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recurredbillid': recurredbillid,
      'subscription_billid': subscriptionBillId,
      'site_Ids': siteIds,
      'client_addressname': clientAddressName,
      'client_address': clientAddress,
      'billing_addressname': billingAddressName,
      'billing_address': billingAddress,
      // 'pdf_data': {'type': 'Buffer', 'data': pdfData},
      'pdfpath': pdfPathString,
      'Invoice_no': invoiceNo,
      'TotalAmount': totalAmount,
      'email_id': emailId,
      'phone_no': phoneNo,
      'ccemail': ccEmail,
      "date": date,
    };
  }
}
/// This class represents a process in the subscription management system.
/// It includes properties like companyList .
/// It provides methods to create an instance from JSON and to convert the object to JSON.
class CompanyResponse {
  final List<CompanysData> companyList;

  CompanyResponse({required this.companyList});

  /// Convert from JSON
  factory CompanyResponse.fromJson(Map<String, dynamic> json) {
    List<CompanysData> liveList = (json['Live'] as List<dynamic>? ?? []).map((e) => CompanysData.fromJson(e as Map<String, dynamic>)).toList();

    List<CompanysData> demoList = (json['Demo'] as List<dynamic>? ?? []).map((e) => CompanysData.fromJson(e as Map<String, dynamic>)).toList();

    return CompanyResponse(companyList: [...liveList, ...demoList]); // Merging both lists
  }

  /// Convert from CMDmResponse
  factory CompanyResponse.fromCMDlResponse(CMDmResponse response) {
    var data = response.data['Live'][0];

    data.forEach((key, value) {
      if (key != 'Customer_Logo') {
        if (kDebugMode) {
          print('$key: $value');
        }
      }
    });

    return CompanyResponse.fromJson(response.data);
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'companyList': companyList.map((e) => e.toJson()).toList(),
    };
  }
}
/// This class represents a process in the subscription management system.
/// It includes properties like customer Id,organization Id,customer Name,ccode,email,customer Logo,address,billing Address,site Type,contact Person,contact Person No ,customer CIN,customer PAN,customer Code ,customerType and isSelected.
/// It provides methods to create an instance from JSON and to convert the object to JSON.
class CompanysData {
  final int? customerId;
  final int? organizationId;
  final String? customerName;
  final String? ccode;
  final String? email;
  final Uint8List? customerLogo;
  final String? address;
  final String? billingAddress;
  final String? siteType;
  final String? contactPerson;
  final String? contactPersonNo;
  final String? customerCIN;
  final String? customerPAN;
  final String? customerCode;
  final int? customerType;
  bool isSelected;

  CompanysData({
    this.customerId,
    this.organizationId,
    this.customerName,
    this.ccode,
    this.email,
    this.customerLogo,
    this.address,
    this.billingAddress,
    this.siteType,
    this.contactPerson,
    this.contactPersonNo,
    this.customerCIN,
    this.customerPAN,
    this.customerCode,
    this.customerType,
    this.isSelected = false,
  });

  factory CompanysData.fromJson(Map<String, dynamic> json) {
    return CompanysData(
      customerId: json['Customer_id'] as int? ?? 0,
      organizationId: json['Organization_id'] as int? ?? 0,
      customerName: json['Customer_name'] as String? ?? "",
      ccode: json['ccode'] as String? ?? "",
      email: json['Email_id'] as String? ?? "",
      customerLogo: json['Customer_Logo'] != null && json['Customer_Logo']['data'] != null ? Uint8List.fromList(List<int>.from(json['Customer_Logo']['data'])) : Uint8List(0),
      address: json['address'] as String? ?? "",
      billingAddress: json['billing_address'] as String? ?? "",
      siteType: json['site_type'] as String? ?? "",
      contactPerson: json['contactperson'] as String? ?? "",
      contactPersonNo: json['contactpersonno'] as String? ?? "",
      customerCIN: json['customer_cin'] as String? ?? "",
      customerPAN: json['customer_pan'] as String? ?? "",
      customerCode: json['customercode'] as String? ?? "",
      customerType: json['customer_type'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Customer_id': customerId,
      'Organization_id': organizationId,
      'Customer_name': customerName,
      'ccode': ccode,
      'Email_id': email,
      'Customer_Logo': customerLogo ?? Uint8List(0),
      'address': address,
      'billing_address': billingAddress,
      'site_type': siteType,
      'contactperson': contactPerson,
      'contactpersonno': contactPersonNo,
      'customer_cin': customerCIN,
      'customer_pan': customerPAN,
      'customercode': customerCode,
      'customer_type': customerType,
    };
  }
}
/// This class represents a process in the subscription management system.
/// It includes properties like global Package List .
/// It provides methods to create an instance from JSON and to convert the object to JSON.
class Global_package {
  final List<Global_packageList> globalPackageList;

  Global_package({required this.globalPackageList});

  /// Convert from CMDmResponse
  factory Global_package.fromCMDlResponse(CMDlResponse response) {
    var data = response.data;
    List<Global_packageList> temp = [];
    for (int i = 0; i < data.length; i++) {
      temp.add(Global_packageList.fromJson(data[i]));
    }
    return Global_package(globalPackageList: temp);
  }
}
/// This class represents a process in the subscription management system.
/// It includes properties like subscription Id,subscription Name,no Of Devices , add Cameras ,amount,product Description and siteDetails .
/// It provides methods to create an instance from JSON and to convert the object to JSON.
class Global_packageList {
  int? subscriptionId;
  String? subscriptionName;
  int? noOfDevices;
  int? noOfCameras;
  int? addlCameras;
  double? amount;
  String? productDesc;
  List<SiteDetail>? siteDetails;

  Global_packageList({
    this.subscriptionId,
    this.subscriptionName,
    this.noOfDevices,
    this.noOfCameras,
    this.addlCameras,
    this.amount,
    this.productDesc,
    this.siteDetails,
  });

  factory Global_packageList.fromJson(Map<String, dynamic> json) {
    return Global_packageList(
      subscriptionId: json['Subscription_id'],
      subscriptionName: json['Subscription_name'],
      noOfDevices: json['No_of_devices'],
      noOfCameras: json['No_of_cameras'],
      addlCameras: json['Addl_cameras'],
      amount: (json['Amount'] as num).toDouble(),
      productDesc: json['product_desc'],
      siteDetails: (json['sitedetails'] as List).map((site) => SiteDetail.fromJson(site)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Subscription_id': subscriptionId,
      'Subscription_name': subscriptionName,
      'No_of_devices': noOfDevices,
      'No_of_cameras': noOfCameras,
      'Addl_cameras': addlCameras,
      'Amount': amount,
      'product_desc': productDesc,
      'sitedetails': siteDetails?.map((site) => site.toJson()).toList(),
    };
  }

  static List<Global_packageList> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Global_packageList.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> toJsonList(List<Global_packageList> subscriptions) {
    return subscriptions.map((sub) => sub.toJson()).toList();
  }
}

/// This class represents a process in the subscription management system.
/// It includes properties like site Name .
/// It provides methods to create an instance from JSON and to convert the object to JSON.
class SiteDetail {
  String? siteName;
  // String? siteLocation;
  int? siteId;

  SiteDetail({
    this.siteName,
    // this.siteLocation,
    this.siteId,
  });

  factory SiteDetail.fromJson(Map<String, dynamic> json) {
    return SiteDetail(
      siteName: json['sitename'],
      // siteLocation: json['site_location'],
      siteId: json['siteid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'site_name': siteName,
      // 'site_location': siteLocation,
      'site_id': siteId,
    };
  }
}
