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

class InvoiceView extends StatefulWidget {
   InvoiceView({super.key});

  @override
  State<InvoiceView> createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {

  final CartController _cartController=Get.find();
  final HomeController homeController = Get.put(HomeController());
  final PaymentController _paymentController = Get.put(PaymentController());
  final ProfileController _profileController = Get.put(ProfileController());
  BranchData? branchData;
  String transactionId='';

 @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((__)async{
      branchData = await homeController.saveBranchInfo();
      setState(() {});
      previousPageData();
      }
    );
  }

  previousPageData(){
   final transId = Get.arguments['transactionId'];
   setState(() {
     transactionId = transId;
   });
  }
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
    return Scaffold(
        appBar: const CustomAppBarTitle(),
      body: Padding(
        padding:  EdgeInsets.all(8.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBarContactInfo(branchData: branchData),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppCustomTextOrIconButton(text: 'In Progress', onTab: (){},buttonColor: Colors.blue.shade50,isBorderActive: true,borderColors: Colors.blue,textColor: Colors.blue,),
                CustomIconTextButton(
                    onPressed: ()async{
                  await generateShareInvoice();
                  // _cartController.clearCart();
                }, icon:Icons.receipt, label: 'Invoice')
              ],
            ),
             SizedBox(height: 16.h),
            Obx((){
              return Text('Order ID : ${_paymentController.paymentResponseModel.value.data?.orderId ?? ''}',
                style: AppStyles.h4(color: AppColors.primaryColor,fontWeight: FontWeight.bold),
              );
            }),
             SizedBox(height: 5.h),
            Text(
              'Order date: $formattedDate',
              style:  AppStyles.h5(color: Colors.black54),
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
                Divider(color: Colors.grey.shade400,),

                // Cart Item
                ...List.generate(_cartController.cartItems.length, (index){
                  final cartItem= _cartController.cartItems[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///Name
                        Text(cartItem.name,style: AppStyles.h5(),),
                        ///Qty
                        Text(cartItem.quantity.toString(),style: AppStyles.h5()),
                        /// Assembly
                        Text('\$${cartItem.assemblyCost.toStringAsFixed(2)}',style: AppStyles.h5()),
                        /// Total

                       ///ki ki kire nony ki???
                        Text(
                          ' \$${cartItem.totalPrice.toDouble().toStringAsFixed(2)}',
                          style: AppStyles.h5(color: AppColors.primaryColor),
                        ),                      ],
                    ),
                  );
                }),
                verticalSpacing(12.h),
                Text('Shipping :-',style: AppStyles.h4(),),
                verticalSpacing(8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('By J&K Cabinetry',style: AppStyles.h4(),),
                      Text('\$${_cartController.isShip.value?_cartController.shippingCost.toStringAsFixed(2):0.toStringAsFixed(2)}',style: AppStyles.h5(),),
                    ],
                  ),
                ),
                Divider(color: Colors.grey.shade400,),
                verticalSpacing(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sub-Total :',style: AppStyles.h4()),
                    Text('\$${ _cartController.subtotal.value.toStringAsFixed(2)}',style: AppStyles.h5()),
                  ],
                ),
                verticalSpacing(14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx((){
                      final tax = _profileController.profileModel.value.data?.branchTax ?? 0.0;
                      final isTax = _profileController.profileModel.value.data?.isTax ?? false;
                      return Text(
                          'Sales Tax (${isTax ? tax : 0}%) :', style: AppStyles.h4());
                    }),
                    Obx((){
                      final tax = _profileController.profileModel.value.data?.branchTax ?? 0.0;
                      final isTax = _profileController.profileModel.value.data?.isTax ?? false;
                      return Text(
                          '\$${((isTax ? tax : 0) * _cartController.subtotal.value / 100).toStringAsFixed(2)}',
                          style: AppStyles.h5());
                    }),
                  ],
                ),
                verticalSpacing(12.h),
              ],
            ),
            verticalSpacing(15.h),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total :',style: AppStyles.h1(color: AppColors.primaryColor),),
                  Text(' \$${_cartController.inTotal.value.toDouble().toStringAsFixed(2)}',
                    style: AppStyles.h1(color: AppColors.primaryColor),
                  ),
                ],
              );
            }),
            verticalSpacing(15.h),
          ],
        ),
      ),
    );
  }

  Future<void> generateShareInvoice() async {
    String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    final pdf = pw.Document();
    // Load your custom fonts (if needed)
    final pw.Font customFont = pw.Font.ttf(await rootBundle.load('assets/font/Outfit-Medium.ttf'));

    // Generate the invoice PDF
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Text(
            'Invoice',
            style: pw.TextStyle(fontSize: 24, font: customFont),
          ),
          pw.SizedBox(height: 16.h),
          pw. Text('Order ID : ${_paymentController.paymentResponseModel.value.data?.orderId ?? ''}',
          ),
          pw.SizedBox(height: 5.h),
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
              // Cart Items
              ...List.generate(_cartController.cartItems.length, (index) {
                final cartItem = _cartController.cartItems[index];
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 6),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(cartItem.name),
                      pw.Text(cartItem.quantity.toString()),
                      pw.Text('\$${cartItem.assemblyCost.toStringAsFixed(2)}'),
                      pw.Text('\$${cartItem.totalPrice.toStringAsFixed(2)}'),
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
                  pw.Text(
                    '\$${_cartController.isShip.value ? _cartController.shippingCost.toStringAsFixed(2) : '0.00'}',
                    style: pw.TextStyle(fontSize: 16, font: customFont),
                  ),
                ],
              ),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('Sub-Total :', style: pw.TextStyle(fontSize: 18, font: customFont)),
                  pw.Text('\$${_cartController.subtotal.value.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 18, font: customFont)),
                ],
              ),
              pw.SizedBox(height: 14),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Sales Tax (${_profileController.profileModel.value.data?.isTax ?? false ? _profileController.profileModel.value.data?.branchTax ?? 0 : 0}%) :',
                    style: pw.TextStyle(fontSize: 18, font: customFont),
                  ),
                  pw.Text(
                    '\$${((_profileController.profileModel.value.data?.isTax ?? false ? _profileController.profileModel.value.data?.branchTax ?? 0 : 0) * _cartController.subtotal.value / 100).toStringAsFixed(2)}',
                    style: pw.TextStyle(fontSize: 18, font: customFont),
                  ),
                ],
              ),
              pw.SizedBox(height: 12),
            ],
          ),
          pw.SizedBox(height: 15),
          // Total Price Section
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Total :', style: pw.TextStyle(fontSize: 22, font: customFont, color: PdfColors.blue)),
              pw.Text(
                '\$${_cartController.inTotal.value.toStringAsFixed(2)}',
                style: pw.TextStyle(fontSize: 22, font: customFont, color: PdfColors.blue),
              ),
            ],
          ),
          pw.SizedBox(height: 15),
        ],
      ),
    );

    // Get the temporary directory path
    final output = await getTemporaryDirectory();
    final file = XFile.fromData(await pdf.save(), mimeType: 'text/plain');
    // Save the PDF to the file
   // await file.writeAsBytes(await pdf.save());

   final fileParams= ShareParams(text: 'Invoice PDF',files:[file],fileNameOverrides: ['my invoice.pdf']);
   final result = await SharePlus.instance.share(fileParams);
   if(result.status == ShareResultStatus.success){
    await _cartController.clearCart();
     Get.snackbar('Success', 'Invoice PDF shared successfully');
   }
  }

}
