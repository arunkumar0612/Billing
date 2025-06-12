class API {
  /////////////////////-----------ADMIN-------------//////////////////////////////////
  static String Login_API = "http://192.168.0.200:8082/admin/login";
  static String Register_API = "http://192.168.0.200:8082/admin/register";
  static String forgotpassword_API = "http://192.168.0.200:8082/admin/forgotpassword";
  static String verifyOTP_API = "http://192.168.0.200:8082/admin/verifyotp";
  static String newpassword_API = "http://192.168.0.200:8082/admin/newpassword";
  static String sales_fetchOrg_list = "http://192.168.0.200:8082/admin/organizationlist";
  static String sales_fetchCompany_list = "http://192.168.0.200:8082/admin/company";
  static String sales_fetchBranch_list = "http://192.168.0.200:8082/admin/branchlist";
  static String sales_add_client_requirement_API = "http://192.168.0.200:8082/admin/sendmailwhatsapp";
  static String send_anyPDF = "http://192.168.0.200:8082/admin/sendpdf";
  ////////////////////////-----------SALES-------------//////////////////////////////////

  static String Upload_MOR_API = "http://192.168.0.200:8082/sales/uploadmor";
  static String sales_add_details_API = "http://192.168.0.200:8082/sales/add";
  static String add_Quotation = "http://192.168.0.200:8082/sales/addquotation";
  static String add_RevisedQuotation = "http://192.168.0.200:8082/sales/addrevisedquotation";
  static String add_Dc = "http://192.168.0.200:8082/sales/adddeliverychallan";
  static String add_RFQ = "http://192.168.0.200:8082/sales/addrfq";

  static String add_salesCustomInvoice = "http://192.168.0.200:8082/sales/addcustominvoice";
  static String add_salesCustomQuote = "http://192.168.0.200:8082/sales/addcustomquotation";
  static String add_salesCustomDc = "http://192.168.0.200:8082/sales/addcustomdc";
  static String get_salesCustompdf = "http://192.168.0.200:8082/sales/getcustompdf";

  static String add_invoice = "http://192.168.0.200:8082/sales/addinvoice";
  static String add_rfq = "http://192.168.0.200:8082/sales/addrfq";
  static String fetch_vendorList = "http://192.168.0.200:8082/vendor/getvendor";

  static String sales_detailsPreLoader_API = "http://192.168.0.200:8082/sales/detailspreloader";
  static String sales_getcustomerlist_API = "http://192.168.0.200:8082/sales/getcustomerlist";
  static String sales_getprocesscustomer_API = "http://192.168.0.200:8082/sales/getprocesscustomer";
  static String sales_getprocesslist_API = "http://192.168.0.200:8082/sales/getprocesslist";
  static String sales_addfeedback_API = "http://192.168.0.200:8082/sales/addfeedback";
  static String sales_getbinaryfile_API = "http://192.168.0.200:8082/sales/getbinaryfile";
  static String sales_getcustombinaryfile_API = "http://192.168.0.200:8082/sales/getcustombinaryfile";

  static String sales_deleteprocess_API = "http://192.168.0.200:8082/sales/deleteprocess";
  static String sales_archiveprocess_API = "http://192.168.0.200:8082/sales/archiveprocess";
  static String sales_getProduct_SUGG_List = "http://192.168.0.200:8082/sales/getproducts";
  static String sales_getNote_SUGG_List = "http://192.168.0.200:8082/sales/getnotes";
  static String sales_getsalesdata_API = "http://192.168.0.200:8082/sales/salesdata";
  static String sales_clientprofile_API = "http://192.168.0.200:8082/sales/clientprofile";
  static String sales_approvedquotation_API = "http://192.168.0.200:8082/sales/approvedquotation";

  // SUBSCRIPTION ////////////
  static String subscriptionadd_Quotation = "http://192.168.0.200:8082/subscription/addquotation";
  static String subscription_add_RevisedQuotation = "http://192.168.0.200:8082/subscription/addrevisedquotation";

  static String subscription_detailsPreLoader_API = "http://192.168.0.200:8082/subscription/detailspreloader";
  static String subscription_getprocesslist_API = "http://192.168.0.200:8082/subscription/getprocesslist";
  static String subscription_addfeedback_API = "http://192.168.0.200:8082/subscription/addfeedback";
  static String subscription_getprocesscustomer_API = "http://192.168.0.200:8082/subscription/getprocesscustomer";
  static String subscription_getrecurredcustomer_API = "http://192.168.0.200:8082/subscription/getrecurredcustomer";
  static String subscription_getApprovalQueue_customer_API = "http://192.168.0.200:8082/subscription/getapprovalcustomer";
  static String subscription_getbinaryfile_API = "http://192.168.0.200:8082/subscription/getbinaryfile";
  static String subscription_deleteprocess_API = "http://192.168.0.200:8082/subscription/deleteprocess";
  static String subscription_archiveprocess_API = "http://192.168.0.200:8082/subscription/archiveprocess";
  static String subscription_clientprofile_API = "http://192.168.0.200:8082/subscription/clientprofile";
  static String subscription_uploadSubscription = "http://192.168.0.200:8082/subscription/uploadsubscription";

  // static String subscription_approvedquotation_API = "http://192.168.0.200:8082/subscription/approvedquotation";
  static String subscription_Upload_MOR_API = "http://192.168.0.200:8082/subscription/uploadmor";
  static String subscription_add_details_API = "http://192.168.0.200:8082/subscription/addsubscus";
  static String subscription_getsubscriptiondata_API = "http://192.168.0.200:8082/subscription/subscriptiondata";
  static String subscription_addCustomInvoice_API = "http://192.168.0.200:8082/subscription/addcustominvoice";
  static String get_subscription_RecurringInvoiceList = "http://192.168.0.200:8082/subscription/getrecurredinvoice";
  static String get_subscription_ApprovalQueueList = "http://192.168.0.200:8082/subscription/getapprovalinvoice";
  static String get_subscription_GlobalPackageList = "http://192.168.0.200:8082/subscription/getglobalsubscription";
  static String get_CompanyBasedPackageList = "http://192.168.0.200:8082/admin/getsubscription";
  static String create_subscription_GlobalPackage = "http://192.168.0.200:8082/admin/createsubscription";
  static String update_subscription_GlobalPackage = "http://192.168.0.200:8082/admin/updatesubscription/";
  static String delete_subscription_GlobalPackage = "http://192.168.0.200:8082/admin/deletesubscription/";
  static String get_subscriptionCustompdf = "http://192.168.0.200:8082/subscription/getcustompdf";
  static String subscription_getcustombinaryfile_API = "http://192.168.0.200:8082/subscription/getcustombinaryfile";
  static String subscription_getRecurredBinaryfile_API = "http://192.168.0.200:8082/subscription/getrecurredbinaryfile";
  static String subscription_getApprovalBinaryfile_API = "http://192.168.0.200:8082/subscription/getapprovalbinaryfile";
  static String subscription_sendAutoGenerated_invoices_API = "http://192.168.0.200:8082/subscription/sendinvoicemail";

  /////////////////////-----------HIERACHY-------------//////////////////////////////////
  static String hierarchy_OrganizationData = "http://192.168.0.200:8082/admin/organization";
  static String hierarchy_CompanyData = "http://192.168.0.200:8082/admin/companylist";
  static String hierarchy_BranchData = "http://192.168.0.200:8082/admin/sitelist";
  static String hierarchy_UploadImage = "http://192.168.0.200:8082/admin/uploadlogo";
  static String updateOrganization_KYC = "http://192.168.0.200:8082/admin/updateorganization";
  static String updateCompany_KYC = "http://192.168.0.200:8082/admin/updatecompany";
  static String updateBranch_KYC = "http://192.168.0.200:8082/admin/updatebranch";

  /////////////////////-----------BILLING-------------//////////////////////////////////
  static String billing_subscriptionInvoice = "http://192.168.0.200:8082/billing/getsubscriptioninvoice";
  static String billing_salesInvoice = "http://192.168.0.200:8082/billing/getsalesinvoice";
  static String get_ledgerSubscriptionCustomers = "http://192.168.0.200:8082/billing/getsubscriptioncustomer";
  static String get_ledgerSalesCustomers = "http://192.168.0.200:8082/billing/getsalescustomer";
  /////////////////////-----------VOUCHER-------------//////////////////////////////////
  static String getvoucherlist = "http://192.168.0.200:8082/billing/getvoucher";
  static String add_overdue = "http://192.168.0.200:8082/billing/addoverduedetails";
  static String clearVoucher = "http://192.168.0.200:8082/billing/clearvoucher";
  static String get_transactionBinaryfile = "http://192.168.0.200:8082/billing/gettransactionfile";
  static String get_receiptBinaryfile = "http://192.168.0.200:8082/billing/getreceiptfile";

  static String clearClubVoucher = "http://192.168.0.200:8082/billing/clearconsolidatevoucher";

  static String getaccount_Ledgerlist = "http://192.168.0.200:8082/billing/accountledger";
  static String getgst_Ledgerlist = "http://192.168.0.200:8082/billing/gstledger";
  static String gettds_Ledgerlist = "http://192.168.0.200:8082/billing/tdsledger";
  static String get_dashboardData = "http://192.168.0.200:8082/billing/getdashboard";
  static String update_transactionDetails = "http://192.168.0.200:8082/billing/updatepaymentdetails";
}
