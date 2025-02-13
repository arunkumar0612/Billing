import 'package:flutter/material.dart';
import 'package:ssipl_billing/models/entities/Response_entities.dart';

class Customer {
  final int customerId;
  final String customerName;
  final String? ccode;
  final String subRequirementId;

  Customer({
    required this.customerId,
    required this.customerName,
    this.ccode,
    required this.subRequirementId,
  });

  factory Customer.fromJson(CMDlResponse json, int i) {
    return Customer(
      customerId: json.data[i]['Customer_id'] as int,
      customerName: json.data[i]['customer_name'] as String,
      ccode: json.data[i]['ccode'] as String?,
      subRequirementId: json.data[i]['Sub_requirement_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Customer_id': customerId,
      'customer_name': customerName,
      'ccode': ccode,
      'Sub_requirement_id': subRequirementId,
    };
  }
}

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
      customerId: json.data[i]['Customer_id'] as int,
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
    return Process(
      processid: json.data[i]['processid'] as int,
      title: json.data[i]['title'] ?? '',
      customer_name: json.data[i]['customer_name'] as String,
      Process_date: json.data[i]['Process_date'] as String,
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

class TimelineEvent {
  final String pdfpath;
  final TextEditingController feedback;
  final String Eventname;
  final int Eventid;
  final Allowedprocess Allowed_process;

  TimelineEvent({
    required this.pdfpath,
    required this.feedback,
    required this.Eventname,
    required this.Eventid,
    required this.Allowed_process,
  });

  factory TimelineEvent.fromJson(Map<String, dynamic> json) {
    return TimelineEvent(
        pdfpath: json['pdfpath'] as String? ?? '',
        feedback: TextEditingController(text: json['feedback'] as String? ?? ''),
        Eventname: json['Eventname'] as String? ?? '',
        Eventid: json['Eventid'] as int,
        Allowed_process: Allowedprocess.fromJson(json['Allowed_process'] != null ? json['Allowed_process'] as Map<String, dynamic> : {}));
  }

  Map<String, dynamic> toJson() {
    return {
      'pdfpath': pdfpath,
      'feedback': feedback,
      'Eventname': Eventname,
      'Eventid': Eventid,
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

  Allowedprocess({
    required this.rfq,
    required this.invoice,
    required this.quotation,
    required this.debit_note,
    required this.credit_note,
    required this.delivery_challan,
    required this.revised_quatation,
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
    };
  }
}
