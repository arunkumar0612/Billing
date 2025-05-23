// ignore_for_file: file_names

import '../../../../UTILS/helpers/support_functions.dart';

class Site {
  static int _counter = 1; // Static counter to auto-increment serial numbers
  String serialNo;
  String siteName;
  String address;
  String siteID;
  double monthlyCharges;

  Site({required this.siteName, required this.address, required this.siteID, required this.monthlyCharges}) : serialNo = (_counter++).toString(); // Auto-increment serial number

  // Convert List of JSON Maps to List of Site objects
  static List<Site> fromJson(List<Map<String, dynamic>> jsonList) {
    _counter = 1; // Reset counter before parsing a new list

    return jsonList.map((json) {
      return Site(
        siteName: json['sitename'] as String, // Fix key casing
        address: json['address'] as String,
        siteID: json['customerid'] as String,
        monthlyCharges: json['monthlycharges'] as double,
      );
    }).toList();
  }

  // Convert List of Site objects to JSON List
  static List<Map<String, dynamic>> toJsonList(List<Site> sites) {
    return sites.map((site) => site.toJson()).toList();
  }

  // Convert single Site object to JSON
  Map<String, dynamic> toJson() {
    return {'serialNo': serialNo, 'siteName': siteName, 'address': address, 'siteID': siteID, 'monthlyCharges': monthlyCharges};
  }

  dynamic getIndex(int col) {
    switch (col) {
      case 0:
        return serialNo;
      case 1:
        return "$siteName||$address"; // Using '||' as a separator

      case 2:
        return "KVROHAR";
      case 3:
        return monthlyCharges;
      default:
        return "";
    }
  }
}

class Address {
  final String billingName;
  final String billingAddress;
  final String installation_serviceName;
  final String installation_serviceAddress;

  Address({required this.billingName, required this.billingAddress, required this.installation_serviceName, required this.installation_serviceAddress});

  // Convert JSON to Address object
  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      billingName: json['billingName'] as String,
      billingAddress: json['billingAddress'] as String,
      installation_serviceName: json['installation_serviceName'] as String,
      installation_serviceAddress: json['installation_serviceAddress'] as String,
    );
  }

  // Convert Address object to JSON
  Map<String, dynamic> toJson() {
    return {'billingName': billingName, 'billingAddress': billingAddress, 'installation_serviceName': installation_serviceName, 'installation_serviceAddress': installation_serviceAddress};
  }
}

class BillPlanDetails {
  final String planName;
  final String customerType;
  final String planCharges;
  final double internetCharges;
  final String billPeriod;
  // final String billDate;
  final String dueDate;

  BillPlanDetails({
    required this.planName,
    required this.customerType,
    required this.planCharges,
    required this.internetCharges,
    required this.billPeriod,
    // required this.billDate,
    required this.dueDate,
  });

  // Convert JSON to BillPlanDetails object
  factory BillPlanDetails.fromJson(Map<String, dynamic> json) {
    return BillPlanDetails(
      planName: json['planName'] as String,
      customerType: json['customerType'] as String,
      planCharges: json['planCharges'] as String,
      internetCharges: (json['internetCharges'] as num).toDouble(),
      billPeriod: json['billPeriod'] as String,
      // billDate: json['billDate'] as String,
      dueDate: json['dueDate'] as String,
    );
  }

  // Convert BillPlanDetails object to JSON
  Map<String, dynamic> toJson() {
    return {
      'planName': planName,
      'customerType': customerType,
      'planCharges': planCharges,
      'internetCharges': internetCharges,
      'billPeriod': billPeriod,
      // 'billDate': billDate,
      'dueDate': dueDate,
    };
  }
}

class CustomerAccountDetails {
  final String relationshipId;
  // final String billNumber;
  final String customerGSTIN;
  final String hsnSacCode;
  final String customerPO;
  final String contactPerson;
  final String contactNumber;

  CustomerAccountDetails({
    required this.relationshipId,
    // required this.billNumber,
    required this.customerGSTIN,
    required this.hsnSacCode,
    required this.customerPO,
    required this.contactPerson,
    required this.contactNumber,
  });

  // Convert JSON to CustomerAccountDetails object
  factory CustomerAccountDetails.fromJson(Map<String, dynamic> json) {
    return CustomerAccountDetails(
      relationshipId: json['relationshipId'] as String,
      // billNumber: json['billNumber'] as String,
      customerGSTIN: json['customerGSTIN'] as String,
      hsnSacCode: json['hsnSacCode'] as String,
      customerPO: json['customerPO'] as String,
      contactPerson: json['contactPerson'] as String,
      contactNumber: json['contactNumber'] as String,
    );
  }

  // Convert CustomerAccountDetails object to JSON
  Map<String, dynamic> toJson() {
    return {
      'relationshipId': relationshipId,
      // 'billNumber': billNumber,
      'customerGSTIN': customerGSTIN,
      'hsnSacCode': hsnSacCode,
      'customerPO': customerPO,
      'contactPerson': contactPerson,
      'contactNumber': contactNumber,
    };
  }
}

class TotalcaculationTable {
  final String previousdues;
  final String payment;
  final String adjustments_deduction;
  final String currentcharges;
  final String totalamountdue;
  TotalcaculationTable({required this.previousdues, required this.payment, required this.adjustments_deduction, required this.currentcharges, required this.totalamountdue});

  // Convert JSON to Address object
  factory TotalcaculationTable.fromJson(Map<String, dynamic> json) {
    return TotalcaculationTable(
      previousdues: json['previousdues'] as String,
      payment: json['payment'] as String,
      adjustments_deduction: json['adjustments_deduction'] as String,
      currentcharges: json['currentcharges'] as String,
      totalamountdue: json['totalamountdue'] as String,
    );
  }

  // Convert Address object to JSON
  Map<String, dynamic> toJson() {
    return {'previousdues': previousdues, 'payment': payment, 'adjustments_deduction': adjustments_deduction, 'currentcharges': currentcharges, 'totalamountdue': totalamountdue};
  }
}

class SUBSCRIPTION_Custom_Invoice {
  final String date;
  final String invoiceNo;
  final double? pendingAmount;
  final int gstPercent;
  final Address addressDetails;
  final BillPlanDetails billPlanDetails;
  final CustomerAccountDetails customerAccountDetails;
  final List<Site> siteData;
  final FinalCalculation finalCalc;
  final List<String> notes;
  final List<PendingInvoices> pendingInvoices;
  final TotalcaculationTable totalcaculationtable;
  final bool ispendingamount;
  SUBSCRIPTION_Custom_Invoice({
    required this.date,
    required this.invoiceNo,
    required this.gstPercent,
    required this.pendingAmount,
    required this.addressDetails,
    required this.billPlanDetails,
    required this.customerAccountDetails,
    required this.siteData,
    required this.finalCalc,
    required this.notes,
    required this.pendingInvoices,
    required this.totalcaculationtable,
    required this.ispendingamount,
  });

  // Convert JSON to Invoice object
  factory SUBSCRIPTION_Custom_Invoice.fromJson(Map<String, dynamic> json) {
    return SUBSCRIPTION_Custom_Invoice(
      date: json['date'] as String,
      invoiceNo: json['invoiceNo'] as String,
      gstPercent: json['gstPercent'] as int,
      pendingAmount: json['pendingAmount'] as double,
      addressDetails: Address.fromJson(json['addressDetails']),
      billPlanDetails: BillPlanDetails.fromJson(json['billPlanDetails']),
      customerAccountDetails: CustomerAccountDetails.fromJson(json['customerAccDetails']),
      siteData: Site.fromJson(List<Map<String, dynamic>>.from(json['siteData'])),
      finalCalc: FinalCalculation.fromJson(Site.fromJson(List<Map<String, dynamic>>.from(json['siteData'])), json['gstPercent'] as int, json['pendingAmount'] as double),
      notes: ['This is a sample note', 'This is another sample note'],
      pendingInvoices: [],
      totalcaculationtable: TotalcaculationTable.fromJson(json['totalcaculationtable']),
      ispendingamount: json['ispendingamount'] as bool,
    );
  }

  // Convert Invoice object to JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'invoiceNo': invoiceNo,
      'pendingAmount': pendingAmount,
      'gstPercent': gstPercent,
      'billPlanDetails': billPlanDetails.toJson(),
      'customerAccDetails': customerAccountDetails.toJson(),
      'siteData': Site.toJsonList(siteData), // Corrected Site List Serialization
      'finalCalc': finalCalc.toJson(),
      'addressDetails': addressDetails.toJson(),
      'notes': notes,
      'totalcaculationtable': totalcaculationtable,
      'ispendingamount': ispendingamount
    };
  }
}

class PendingInvoices {
  final String serialNo;
  final String invoiceid;
  final String duedate;
  final String overduedays;
  final double charges;

  PendingInvoices(this.serialNo, this.invoiceid, this.duedate, this.overduedays, this.charges);

  // Convert JSON (Map) to PendingInvoices object
  factory PendingInvoices.fromJson(Map<String, dynamic> json) {
    return PendingInvoices(json['serialNo'] ?? '', json['invoiceid'] ?? '', json['duedate'] ?? '', json['overduedays'] ?? '', (json['charges'] ?? 0.0).toDouble());
  }

  // Convert PendingInvoices object to JSON (Map)
  Map<String, dynamic> toJson() {
    return {'serialNo': serialNo, 'invoiceid': invoiceid, 'duedate': duedate, 'overduedays': overduedays, 'charges': charges};
  }

  // Convert List<Map<String, dynamic>> to List<PendingInvoices>
  static List<PendingInvoices> fromJsonList(List<Map<String, dynamic>> jsonList) {
    return jsonList.map((json) => PendingInvoices.fromJson(json)).toList();
  }

  dynamic getIndex(int col) {
    switch (col) {
      case 0:
        return serialNo;
      case 1:
        return invoiceid;
      case 2:
        return duedate;
      case 3:
        return overduedays;
      case 4:
        return charges;
      default:
        return "";
    }
  }
}

class FinalCalculation {
  final double subtotal;
  final double igst;
  final double cgst;
  final double sgst;
  final String roundOff;
  final String differene;
  final double total;
  final double? pendingAmount;
  final double grandTotal;

  FinalCalculation({
    required this.subtotal,
    required this.igst,
    required this.cgst,
    required this.sgst,
    required this.roundOff,
    required this.differene,
    required this.total,
    required this.pendingAmount,
    required this.grandTotal,
  });

  factory FinalCalculation.fromJson(List<Site> sites, int gstPercent, double? pendingAmount) {
    double subtotal = sites.fold(0.0, (sum, site) => sum + site.monthlyCharges);
    double igst = (subtotal * gstPercent) / 100;
    double cgst = (subtotal * (gstPercent / 2)) / 100;
    double sgst = (subtotal * (gstPercent / 2)) / 100;
    double total = subtotal + cgst + sgst;
    double grandTotal = pendingAmount != null ? total + pendingAmount : total;

    return FinalCalculation(
      subtotal: subtotal,
      igst: igst,
      cgst: cgst,
      sgst: sgst,
      roundOff: formatCurrencyRoundedPaisa(total),
      differene:
          '${((double.parse(formatCurrencyRoundedPaisa(total).replaceAll(',', '')) - total) >= 0 ? '+' : '')}${(double.parse(formatCurrencyRoundedPaisa(total).replaceAll(',', '')) - total).toStringAsFixed(2)}',
      total: total,
      pendingAmount: pendingAmount,
      grandTotal: grandTotal,
    );
  }

  Map<String, dynamic> toJson() {
    return {'subtotal': subtotal, 'IGST': igst, 'CGST': cgst, 'SGST': sgst, 'roundOff': roundOff, 'difference': differene, 'total': total, 'pendingAmount': pendingAmount, 'grandTotal': grandTotal};
  }
}

class PostInvoice {
  List<int> siteIds;
  String subscriptionBillId;
  String billingAddressName;
  String billingAddress;
  String installation_serviceAddressName;
  String installation_serviceAddress;
  String? gst;
  String planName;
  String emailId;
  String ccEmail;
  String phoneNo;
  String totalAmount;
  String invoiceGenId;
  String date;
  int messageType;
  String feedback;

  PostInvoice({
    required this.siteIds,
    required this.subscriptionBillId,
    required this.billingAddressName,
    required this.billingAddress,
    required this.installation_serviceAddressName,
    required this.installation_serviceAddress,
    required this.gst,
    required this.planName,
    required this.emailId,
    required this.ccEmail,
    required this.phoneNo,
    required this.totalAmount,
    required this.invoiceGenId,
    required this.date,
    required this.messageType,
    required this.feedback,
  });

  factory PostInvoice.fromJson(Map<String, dynamic> json) {
    return PostInvoice(
      siteIds: List<int>.from(json["siteids"] ?? []),
      subscriptionBillId: json["subscriptionbillid"] ?? "",
      billingAddressName: json["billingaddressname"] ?? "",
      billingAddress: json["billingaddress"] ?? "",
      installation_serviceAddressName: json["installation_serviceaddressname"] ?? "",
      installation_serviceAddress: json["installation_serviceaddress"] ?? "",
      gst: json["gst_number"] ?? "",
      planName: json["planname"] ?? "",
      emailId: json["emailid"] ?? "",
      ccEmail: json["ccemail"] ?? "",
      phoneNo: json["phoneno"] ?? "",
      totalAmount: json["totalamount"] ?? "",
      invoiceGenId: json["invoicegenid"] ?? "",
      date: json["date"] ?? "",
      messageType: json["messagetype"] ?? 0,
      feedback: json["feedback"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "siteids": siteIds,
      "subscriptionbillid": subscriptionBillId,
      "billingaddressname": billingAddressName,
      "billingaddress": billingAddress,
      "installation_serviceaddressname": installation_serviceAddressName,
      "installation_serviceaddress": installation_serviceAddress,
      "gstnumber": gst,
      "planname": planName,
      "emailid": emailId,
      "ccemail": ccEmail,
      "phoneno": phoneNo,
      "totalamount": totalAmount,
      "invoicegenid": invoiceGenId,
      "date": date,
      "messagetype": messageType,
      "feedback": feedback,
    };
  }
}
