class API {
  /////////////////////-----------ADMIN-------------//////////////////////////////////
  static String Login_API = "http://192.168.0.111:8081/admin/login";
  static String Register_API = "http://192.168.0.111:8081/admin/register";
  static String forgotpassword_API = "http://192.168.0.111:8081/admin/forgotpassword";
  static String verifyOTP_API = "http://192.168.0.111:8081/admin/verifyotp";
  static String newpassword_API = "http://192.168.0.111:8081/admin/newpassword";
  static String sales_fetchOrg_list = "http://192.168.0.111:8081/admin/organizationlist";
  static String sales_fetchCompany_list = "http://192.168.0.111:8081/admin/company";
  static String sales_fetchBranch_list = "http://192.168.0.111:8081/admin/branchlist";
  static String sales_add_client_requirement_API = "http://192.168.0.111:8081/admin/sendmailwhatsapp";
  static String send_anyPDF = "http://192.168.0.111:8081/admin/sendpdf";
  ////////////////////////-----------SALES-------------//////////////////////////////////

  static String Upload_MOR_API = "http://192.168.0.111:8081/sales/uploadmor";
  static String sales_add_details_API = "http://192.168.0.111:8081/sales/add";
  static String add_Quotation = "http://192.168.0.111:8081/sales/addquotation";
  static String add_RevisedQuotation = "http://192.168.0.111:8081/sales/addrevisedquotation";
  static String add_Dc = "http://192.168.0.111:8081/sales/adddeliverychallan";
  static String add_RFQ = "http://192.168.0.111:8081/sales/addrfq";

  static String add_salesCustomInvoice = "http://192.168.0.111:8081/sales/addcustominvoice";
  static String add_salesCustomQuote = "http://192.168.0.111:8081/sales/addcustomquotation";
  static String add_salesCustomDc = "http://192.168.0.111:8081/sales/addcustomdc";
  static String get_salesCustompdf = "http://192.168.0.111:8081/sales/getcustompdf";

  static String add_invoice = "http://192.168.0.111:8081/sales/addinvoice";
  static String add_rfq = "http://192.168.0.111:8081/sales/addrfq";
  static String addVendor = 'http://192.168.0.111:8081/vendor/addvendor';

  static String sales_detailsPreLoader_API = "http://192.168.0.111:8081/sales/detailspreloader";
  static String sales_getcustomerlist_API = "http://192.168.0.111:8081/sales/getcustomerlist";
  static String sales_getprocesscustomer_API = "http://192.168.0.111:8081/sales/getprocesscustomer";
  static String sales_getprocesslist_API = "http://192.168.0.111:8081/sales/getprocesslist";
  static String sales_addfeedback_API = "http://192.168.0.111:8081/sales/addfeedback";
  static String sales_getbinaryfile_API = "http://192.168.0.111:8081/sales/getbinaryfile";
  static String sales_getcustombinaryfile_API = "http://192.168.0.111:8081/sales/getcustombinaryfile";

  static String sales_deleteprocess_API = "http://192.168.0.111:8081/sales/deleteprocess";
  static String sales_archiveprocess_API = "http://192.168.0.111:8081/sales/archiveprocess";
  static String sales_getProduct_SUGG_List = "http://192.168.0.111:8081/sales/getproducts";
  static String sales_getNote_SUGG_List = "http://192.168.0.111:8081/sales/getnotes";
  static String sales_getsalesdata_API = "http://192.168.0.111:8081/sales/salesdata";
  static String sales_clientprofile_API = "http://192.168.0.111:8081/sales/clientprofile";
  static String sales_approvedquotation_API = "http://192.168.0.111:8081/sales/approvedquotation";

  // SUBSCRIPTION ////////////
  static String subscriptionadd_Quotation = "http://192.168.0.111:8081/subscription/addquotation";
  static String subscription_add_RevisedQuotation = "http://192.168.0.111:8081/subscription/addrevisedquotation";

  static String subscription_detailsPreLoader_API = "http://192.168.0.111:8081/subscription/detailspreloader";
  static String subscription_getprocesslist_API = "http://192.168.0.111:8081/subscription/getprocesslist";
  static String subscription_addfeedback_API = "http://192.168.0.111:8081/subscription/addfeedback";
  static String subscription_getprocesscustomer_API = "http://192.168.0.111:8081/subscription/getprocesscustomer";
  static String subscription_getrecurredcustomer_API = "http://192.168.0.111:8081/subscription/getrecurredcustomer";
  static String subscription_getApprovalQueue_customer_API = "http://192.168.0.111:8081/subscription/getapprovalcustomer";
  static String subscription_getbinaryfile_API = "http://192.168.0.111:8081/subscription/getbinaryfile";
  static String subscription_deleteprocess_API = "http://192.168.0.111:8081/subscription/deleteprocess";
  static String subscription_archiveprocess_API = "http://192.168.0.111:8081/subscription/archiveprocess";
  static String subscription_clientprofile_API = "http://192.168.0.111:8081/subscription/clientprofile";
  static String subscription_uploadSubscription = "http://192.168.0.111:8081/subscription/uploadsubscription";

  // static String subscription_approvedquotation_API = "http://192.168.0.111:8081/subscription/approvedquotation";
  static String subscription_Upload_MOR_API = "http://192.168.0.111:8081/subscription/uploadmor";
  static String subscription_add_details_API = "http://192.168.0.111:8081/subscription/addsubscus";
  static String subscription_getsubscriptiondata_API = "http://192.168.0.111:8081/subscription/subscriptiondata";
  static String subscription_addCustomInvoice_API = "http://192.168.0.111:8081/subscription/addcustominvoice";
  static String get_subscription_RecurringInvoiceList = "http://192.168.0.111:8081/subscription/getrecurredinvoice";
  static String get_subscription_ApprovalQueueList = "http://192.168.0.111:8081/subscription/getapprovalinvoice";
  static String get_subscription_GlobalPackageList = "http://192.168.0.111:8081/subscription/getglobalsubscription";
  static String get_CompanyBasedPackageList = "http://192.168.0.111:8081/admin/getsubscription";
  static String create_subscription_GlobalPackage = "http://192.168.0.111:8081/admin/createsubscription";
  static String update_subscription_GlobalPackage = "http://192.168.0.111:8081/admin/updatesubscription/";
  static String delete_subscription_GlobalPackage = "http://192.168.0.111:8081/admin/deletesubscription/";
  static String get_subscriptionCustompdf = "http://192.168.0.111:8081/subscription/getcustompdf";
  static String subscription_getcustombinaryfile_API = "http://192.168.0.111:8081/subscription/getcustombinaryfile";
  static String subscription_getRecurredBinaryfile_API = "http://192.168.0.111:8081/subscription/getrecurredbinaryfile";
  static String subscription_getApprovalBinaryfile_API = "http://192.168.0.111:8081/subscription/getapprovalbinaryfile";
  static String subscription_sendAutoGenerated_invoices_API = "http://192.168.0.111:8081/subscription/sendinvoicemail";

  /////////////////////-----------HIERACHY-------------//////////////////////////////////
  static String hierarchy_OrganizationData = "http://192.168.0.111:8081/admin/organization";
  static String hierarchy_CompanyData = "http://192.168.0.111:8081/admin/companylist";
  static String hierarchy_BranchData = "http://192.168.0.111:8081/admin/sitelist";
  static String hierarchy_UploadImage = "http://192.168.0.111:8081/admin/uploadlogo";
  static String updateOrganization_KYC = "http://192.168.0.111:8081/admin/updateorganization";
  static String updateCompany_KYC = "http://192.168.0.111:8081/admin/updatecompany";
  static String updateBranch_KYC = "http://192.168.0.111:8081/admin/updatebranch";

  /////////////////////-----------BILLING-------------//////////////////////////////////
  static String billing_subscriptionInvoice = "http://192.168.0.111:8081/billing/getsubscriptioninvoice";
  static String billing_salesInvoice = "http://192.168.0.111:8081/billing/getsalesinvoice";
  static String get_ledgerSubscriptionCustomers = "http://192.168.0.111:8081/billing/getsubscriptioncustomer";
  static String get_ledgerSalesCustomers = "http://192.168.0.111:8081/billing/getsalescustomer";

  /////////////////////-----------VOUCHER-------------//////////////////////////////////
  static String getvoucherlist = "http://192.168.0.111:8081/billing/getvoucher";
  static String add_overdue = "http://192.168.0.111:8081/billing/addoverduedetails";
  static String clearVoucher = "http://192.168.0.111:8081/billing/clearvoucher";
  static String get_transactionBinaryfile = "http://192.168.0.111:8081/billing/gettransactionfile";
  static String get_receiptBinaryfile = "http://192.168.0.111:8081/billing/getreceiptfile";
  static String clearClubVoucher = "http://192.168.0.111:8081/billing/clearconsolidatevoucher";
  static String getaccount_Ledgerlist = "http://192.168.0.111:8081/billing/accountledger";
  static String getgst_Ledgerlist = "http://192.168.0.111:8081/billing/gstledger";
  static String gettds_Ledgerlist = "http://192.168.0.111:8081/billing/tdsledger";
  static String get_dashboardData = "http://192.168.0.111:8081/billing/getdashboard";
  static String update_transactionDetails = "http://192.168.0.111:8081/billing/updatepaymentdetails";

  /////////////////////-----------VENDOR-------------//////////////////////////////////

  static String RFQ_preloader = "http://192.168.0.111:8081/vendor/detailspreloader";
  static String vendor_productsSuggestion = "http://192.168.0.111:8081/vendor/getproducts";
  static String vendor_getNote_SUGG_List = "http://192.168.0.111:8081/vendor/getnotes";
  static String vendor_createrfq = "http://192.168.0.111:8081/vendor/postrfq";
  static String vendor_getprocesslist_API = "http://192.168.0.111:8081/vendor/getallprocesslist";
  static String vendor_uploadQuote = "http://192.168.0.111:8081/vendor/uploadquotation";
  static String active_vendors = "http://192.168.0.111:8081/vendor/activevendors";
  static String vendor_getPDF = "http://192.168.0.111:8081/vendor/getbinaryfile";
  static String vendor_addfeedback_API = "http://192.168.0.111:8081/vendor/addfeedback";
  static String vendor_deleteprocess_API = "http://192.168.0.111:8081/vendor/deleteprocess";
  static String vendor_archiveprocess_API = "http://192.168.0.111:8081/vendor/archiveprocess";
  static String fetch_vendorList = "http://192.168.0.111:8081/vendor/getvendor";
}
