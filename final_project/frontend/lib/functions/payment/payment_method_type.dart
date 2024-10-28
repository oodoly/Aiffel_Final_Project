enum PaymentMethodType {
  samsungPay("삼성페이", "assets/icons/samsung_pay.png"),
  kakaoPay("카카오페이", "assets/icons/kakao_pay.png"),
  naverPay("네이버페이", "assets/icons/naver_pay.png"),
  payco("페이코", "assets/icons/payco.png");

  final String name;
  final String iconPath;

  const PaymentMethodType(this.name, this.iconPath);
}
