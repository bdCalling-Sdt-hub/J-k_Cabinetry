import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jk_cabinet/app/modules/cart/controllers/cart_controller.dart';
import 'package:jk_cabinet/app/modules/cart/controllers/make_payment_controller.dart';
import 'package:jk_cabinet/app/modules/home/controllers/home_controller.dart';
import 'package:jk_cabinet/app/modules/home/model/branch_model.dart';
import 'package:jk_cabinet/app/modules/home/widgets/topbar_contact_info.dart';
import 'package:jk_cabinet/app/modules/invoice/controllers/invoice_controller.dart';
import 'package:jk_cabinet/common/app_color/app_colors.dart';
import 'package:jk_cabinet/common/app_text_style/style.dart';
import 'package:jk_cabinet/common/widgets/app_custom_textOrIcon_button.dart';
import 'package:jk_cabinet/common/widgets/custom_appBar_title.dart';
import 'package:jk_cabinet/common/widgets/custom_icon_text_button.dart';
import 'package:jk_cabinet/common/widgets/spacing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../profile/controllers/profile_controller.dart';
import '../models/invoice_model.dart';

class InvoiceView extends StatefulWidget {
  InvoiceView({super.key});

  @override
  State<InvoiceView> createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  final CartController _cartController = Get.find();
  final HomeController homeController = Get.put(HomeController());
  final PaymentController _paymentController = Get.put(PaymentController());
  final ProfileController _profileController = Get.put(ProfileController());
  final InvoiceController _invoiceController = Get.put(InvoiceController());

  final Rxn<BranchData> branchData = Rxn<BranchData>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final savedBranch = await homeController.saveBranchInfo();
      branchData.value = savedBranch;
      // Optionally fetch invoice data here if not fetched yet:
      // await _invoiceController.getInvoice();
    });
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    return Scaffold(
      appBar: const CustomAppBarTitle(),
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Obx(() {
          final orderData = _invoiceController.orderResponse.value.data;
          if (orderData == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopBarContactInfo(branchData: branchData.value),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppCustomTextOrIconButton(
                    text: 'In Progress',
                    onTab: () {},
                    buttonColor: Colors.blue.shade50,
                    isBorderActive: true,
                    borderColors: Colors.blue,
                    textColor: Colors.blue,
                  ),
                  CustomIconTextButton(
                    onPressed: () async {
                      await generateShareInvoice(orderData, formattedDate);
                    },
                    icon: Icons.receipt,
                    label: 'Invoice',
                  )
                ],
              ),
              SizedBox(height: 16.h),
              Text(
                'Order ID : ${orderData.orderId ?? ''}',
                style: AppStyles.h4(
                    color: AppColors.primaryColor, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.h),
              Text(
                'Order date: $formattedDate',
                style: AppStyles.h5(color: Colors.black54),
              ),
              SizedBox(height: 16.h),
              ExpansionTile(
                title: Text(
                  'Order Summery',
                  style: AppStyles.h3(),
                ),
                maintainState: true,
                initiallyExpanded: true,
                controlAffinity: ListTileControlAffinity.platform,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Quantity', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Assembly', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Divider(color: Colors.grey.shade400),
                  ...List.generate(orderData.products?.length ?? 0, (index) {
                    final orderItem = orderData.products![index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(orderItem.name ?? '', style: AppStyles.h5()),
                          Text(orderItem.quantity.toString(), style: AppStyles.h5()),
                          Text('\$${orderItem.assembly ?? 0}', style: AppStyles.h5()),
                          Text(
                            ' \$${orderItem.total?.toDouble().toStringAsFixed(2)}',
                            style: AppStyles.h5(color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    );
                  }),
                  verticalSpacing(12.h),
                  Text('Shipping :-', style: AppStyles.h4()),
                  verticalSpacing(8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('By J&K Cabinetry', style: AppStyles.h4()),
                        Text('\$${orderData.shipping ?? 0}', style: AppStyles.h5()),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey.shade400),
                  verticalSpacing(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sub-Total :', style: AppStyles.h4()),
                      Text('\$${orderData.subTotal ?? 0}', style: AppStyles.h5()),
                    ],
                  ),
                  verticalSpacing(14.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sales Tax (${orderData.salesTax ?? 0}%) :', style: AppStyles.h4()),
                      Text('\$${orderData.salesTaxAmount ?? 0}', style: AppStyles.h5()),
                    ],
                  ),
                  verticalSpacing(12.h),
                ],
              ),
              verticalSpacing(15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total :',
                    style: AppStyles.h1(color: AppColors.primaryColor),
                  ),
                  Text(
                    ' \$${orderData.total?.toDouble().toStringAsFixed(2) ?? '0.00'}',
                    style: AppStyles.h1(color: AppColors.primaryColor),
                  ),
                ],
              ),
              verticalSpacing(15.h),
            ],
          );
        }),
      ),
    );
  }

  Future<void> generateShareInvoice(OrderData orderData, String formattedDate) async {
    final pdf = pw.Document();
    final pw.Font customFont =
    pw.Font.ttf(await rootBundle.load('assets/font/Outfit-Medium.ttf'));

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Text(
            'Invoice',
            style: pw.TextStyle(fontSize: 24, font: customFont),
          ),
          pw.SizedBox(height: 16),
          pw.Text('Order ID : ${orderData.orderId ?? ''}'),
          pw.SizedBox(height: 5),
          pw.SizedBox(height: 16),
          pw.Text(
            'Order date: $formattedDate',
            style: pw.TextStyle(fontSize: 18, font: customFont),
          ),
          pw.SizedBox(height: 16),
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Order Summary',
                style: pw.TextStyle(fontSize: 20, font: customFont),
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Name', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Quantity', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Assembly', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ],
              ),
              pw.Divider(),
              ...List.generate(orderData.products?.length ?? 0, (index) {
                final orderItem = orderData.products![index];
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 6),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(orderItem.name ?? ''),
                      pw.Text(orderItem.quantity.toString()),
                      pw.Text('\$${(orderItem.assembly ?? 0).toString()}'),
                      pw.Text('\$${orderItem.total?.toDouble().toStringAsFixed(2) ?? '0.00'}'),
                    ],
                  ),
                );
              }),
              pw.SizedBox(height: 12),
              pw.Text('Shipping:', style: pw.TextStyle(fontSize: 18, font: customFont)),
              pw.SizedBox(height: 8),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('By J&K Cabinetry', style: pw.TextStyle(fontSize: 16, font: customFont)),
                  pw.Text('\$${orderData.shipping?.toDouble().toStringAsFixed(2) ?? '0.00'}',
                      style: pw.TextStyle(fontSize: 16, font: customFont)),
                ],
              ),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Sub-Total :', style: pw.TextStyle(fontSize: 18, font: customFont)),
                  pw.Text('\$${orderData.subTotal?.toDouble().toStringAsFixed(2) ?? '0.00'}',
                      style: pw.TextStyle(fontSize: 18, font: customFont)),
                ],
              ),
              pw.SizedBox(height: 14),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Sales Tax (${orderData.salesTax ?? 0}%) :',
                    style: pw.TextStyle(fontSize: 18, font: customFont),
                  ),
                  pw.Text(
                    '\$${orderData.salesTaxAmount?.toDouble().toStringAsFixed(2) ?? '0.00'}',
                    style: pw.TextStyle(fontSize: 18, font: customFont),
                  ),
                ],
              ),
              pw.SizedBox(height: 12),
            ],
          ),
          pw.SizedBox(height: 15),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Total :', style: pw.TextStyle(fontSize: 22, font: customFont, color: PdfColors.blue)),
              pw.Text(
                '\$${orderData.total?.toDouble().toStringAsFixed(2) ?? '0.00'}',
                style: pw.TextStyle(fontSize: 22, font: customFont, color: PdfColors.blue),
              ),
            ],
          ),
          pw.SizedBox(height: 15),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = XFile.fromData(await pdf.save(), mimeType: 'application/pdf');
    final fileParams = ShareParams(
      text: 'Invoice PDF',
      files: [file],
      fileNameOverrides: ['my_invoice.pdf'],
    );
    final result = await SharePlus.instance.share(fileParams);
    if (result.status == ShareResultStatus.success) {
      await _cartController.clearCart();
      Get.snackbar('Success', 'Invoice PDF shared successfully');
    }
  }
}
