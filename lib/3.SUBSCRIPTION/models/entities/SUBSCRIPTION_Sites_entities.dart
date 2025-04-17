import '../../../UTILS-/helpers/support_functions.dart';

class SUBSCRIPTION_DcSite {
  final int sno;
  final String siteName;
  final int hsn;
  final double gst;
  final double price;
  final int quantity;
  final int siteid;
  const SUBSCRIPTION_DcSite({
    required this.sno,
    required this.siteName,
    required this.hsn,
    required this.gst,
    required this.price,
    required this.quantity,
    required this.siteid,
  });

  /// Calculates the total price for the site
  double get total => price * quantity;

  /// Returns specific values based on the given index
  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno.toString();
      case 1:
        return siteName;
      case 2:
        return hsn.toString();
      case 3:
        return gst.toString();
      case 4:
        return formatCurrency(price);
      case 5:
        return quantity.toString();
      case 6:
        return formatCurrency(total);
      case 7:
        return siteid.toString();
      default:
        return '';
    }
  }

  /// Converts object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'sitesno': sno,
      'sitename': siteName,
      'sitehsn': hsn,
      'sitegst': gst,
      'siteprice': price,
      'sitequantity': quantity,
      'sitetotal': total,
      'siteid': siteid,
    };
  }

  /// Factory constructor to create an instance from JSON
  factory SUBSCRIPTION_DcSite.fromJson(Map<String, dynamic> json) {
    return SUBSCRIPTION_DcSite(
      sno: json['sitesno'] as int,
      siteName: json['sitename'] as String,
      hsn: json['sitehsn'] as int,
      gst: (json['sitegst'] as num).toDouble(),
      price: (json['siteprice'] as num).toDouble(),
      quantity: json['sitequantity'] as int,
      siteid: json['siteid'] as int,
    );
  }
}

class SUBSCRIPTION_QuoteSite {
  final int sno;
  final String siteName;
  final String selectedPackage;
  final PackageDetails? packageDetails;
  final String address;

  SUBSCRIPTION_QuoteSite({
    required this.sno,
    required this.siteName,
    required this.selectedPackage,
    this.packageDetails,
    required this.address,
  });

  /// Calculates the total price for the site
  double getTotalPrice() {
    return packageDetails?.packageAmount ?? 0.0;
  }

  /// Returns specific values based on the given index
  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno.toString();
      case 1:
        return siteName;
      case 2:
        return selectedPackage;
      case 3:
        return address;
      case 4:
        return packageDetails?.cameraCount.toString() ?? '0';
      case 5:
        return (packageDetails?.packageAmount.toStringAsFixed(2) ?? '0.00');
      default:
        return '';
    }
  }

  /// Converts object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'sitesno': sno,
      'sitename': siteName,
      'selectedPackage': selectedPackage,
      'packageDetails': packageDetails?.toJson(),
      'address': address,
    };
  }

  /// Factory constructor to create an instance from JSON
  factory SUBSCRIPTION_QuoteSite.fromJson(Map<String, dynamic> json) {
    return SUBSCRIPTION_QuoteSite(
      sno: json['sitesno'] as int,
      siteName: json['sitename'] as String,
      selectedPackage: json['selectedPackage'] as String,
      packageDetails: json['packageDetails'] != null ? PackageDetails.fromJson(json['packageDetails']) : null,
      address: json['address'] as String,
    );
  }
}

class PackageDetails {
  final String name;
  final int cameraCount;
  final double packageAmount;
  final String additionalCharges;
  final String description;

  PackageDetails({
    required this.name,
    required this.cameraCount,
    required this.packageAmount,
    required this.additionalCharges,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cameraCount': cameraCount,
      'packageAmount': packageAmount,
      'additionalCharges': additionalCharges,
      'description': description,
    };
  }

  factory PackageDetails.fromJson(Map<String, dynamic> json) {
    return PackageDetails(
      name: json['name'] as String,
      cameraCount: json['cameraCount'] as int,
      packageAmount: json['packageAmount'] as double,
      additionalCharges: json['additionalCharges'] as String,
      description: json['description'] as String,
    );
  }
}

class SUBSCRIPTION_RFQSite {
  final int sno;
  final String siteName;
  final int quantity;

  const SUBSCRIPTION_RFQSite({
    required this.sno,
    required this.siteName,
    required this.quantity,
  });

  /// Returns specific values based on the given index
  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno.toString();
      case 1:
        return siteName;
      case 2:
        return quantity.toString();
      default:
        return '';
    }
  }

  /// Converts object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'sitesno': sno,
      'sitename': siteName,
      'sitequantity': quantity,
    };
  }

  /// Factory constructor to create an instance from JSON
  factory SUBSCRIPTION_RFQSite.fromJson(Map<String, dynamic> json) {
    return SUBSCRIPTION_RFQSite(
      sno: json['sitesno'] as int,
      siteName: json['sitename'] as String,
      quantity: json['sitequantity'] as int,
    );
  }
}

// class SUBSCRIPTION_RFQSite {
//   const SUBSCRIPTION_RFQSite(
//     this.sno,
//     this.siteName,
//     this.quantity,
//   );

//   final String sno;
//   final String siteName;

//   final int quantity;

//   String getIndex(int index) {
//     switch (index) {
//       case 0:
//         return sno;
//       case 1:
//         return siteName;
//       case 2:
//         return quantity.toString();
//     }
//     return '';
//   }
// }

class SUBSCRIPTION_CreditSite {
  const SUBSCRIPTION_CreditSite(
    this.sno,
    this.siteName,
    this.hsn,
    this.gst,
    this.price,
    this.quantity,
    this.remarks,
  );

  final String sno;
  final String siteName;
  final String hsn;
  final double gst;
  final double price;
  final int quantity;
  final String remarks;
  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno;
      case 1:
        return siteName;
      case 2:
        return hsn;
      case 3:
        return gst.toString();
      case 4:
        return formatCurrency(price);
      case 5:
        return quantity.toString();
      case 6:
        return formatCurrency(total);
      case 7:
        return remarks;
    }
    return '';
  }
}

class SUBSCRIPTION_DebitSite {
  const SUBSCRIPTION_DebitSite(
    this.sno,
    this.siteName,
    this.hsn,
    this.gst,
    this.price,
    this.quantity,
    this.remarks,
  );

  final String sno;
  final String siteName;
  final String hsn;
  final double gst;
  final double price;
  final int quantity;
  final String remarks;
  double get total => price * quantity;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno;
      case 1:
        return siteName;
      case 2:
        return hsn;
      case 3:
        return gst.toString();
      case 4:
        return formatCurrency(price);
      case 5:
        return quantity.toString();
      case 6:
        return formatCurrency(total);
      case 7:
        return remarks;
    }
    return '';
  }
}

class SUBSCRIPTION_InvoiceSite {
  int sno;
  String siteName;
  int hsn;
  double gst;
  double price;
  int quantity;

  SUBSCRIPTION_InvoiceSite({required this.sno, required this.siteName, required this.hsn, required this.gst, required this.price, required this.quantity});

  /// Calculates the total price for the site
  double get total => price * quantity;

  /// Returns specific values based on the given index
  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno.toString();
      case 1:
        return siteName;
      case 2:
        return hsn.toString();
      case 3:
        return gst.toString();
      case 4:
        return formatCurrency(price);
      case 5:
        return quantity.toString();
      case 6:
        return formatCurrency(total);
      default:
        return '';
    }
  }

  /// Converts object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'sitesno': sno,
      'sitename': siteName,
      'sitehsn': hsn,
      'sitegst': gst,
      'siteprice': price,
      'sitequantity': quantity,
      'sitetotal': total,
    };
  }

  /// Factory constructor to create an instance from JSON
  factory SUBSCRIPTION_InvoiceSite.fromJson(Map<String, dynamic> json) {
    return SUBSCRIPTION_InvoiceSite(
      sno: json['sitesno'] as int,
      siteName: json['sitename'] as String,
      hsn: json['sitehsn'] as int,
      gst: (json['sitegst'] as num).toDouble(),
      price: (json['siteprice'] as num).toDouble(),
      quantity: json['sitequantity'] as int,
    );
  }
}

class SUBSCRIPTION_ClientreqSites {
  const SUBSCRIPTION_ClientreqSites(
    this.sno,
    this.siteName,
    this.cameraquantity,
    this.siteAddress,
  );

  final String sno;
  final String siteName;
  final int cameraquantity;
  final String siteAddress;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return sno;
      case 1:
        return siteName;

      case 2:
        return cameraquantity.toString();
      case 3:
        return siteAddress;
    }
    return '';
  }

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      "sno": sno,
      "sitename": siteName,
      "cameraquantity": cameraquantity,
      "address": siteAddress,
    };
  }
}
