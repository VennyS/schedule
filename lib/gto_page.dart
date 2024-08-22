import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:package_user/package_user.dart';
import 'package:schedule/api/api_service.dart';
import 'package:widgets/widgets.dart';
import 'package:intl/date_symbol_data_local.dart';

class GtoPage extends StatefulWidget {
  final ListItem item;

  const GtoPage({super.key, required this.item});

  @override
  GtoPageState createState() => GtoPageState();
}

class GtoPageState extends State<GtoPage> {
  bool isSignUpWillBeShown = true;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('ru', null);
  }

  @override
  Widget build(BuildContext context) {
    String recordSvg = "assets/svgs/record.svg";
    String avatarPng = "assets/pngs/avatar.png";

    SvgPicture leadingRecordSvg = SvgPicture.asset(
      recordSvg,
      colorFilter: const ColorFilter.mode(Color(0xFF298267), BlendMode.srcIn),
      width: 20, // Ширина SVG
      height: 20, // Высота SVG
    );

    Image leadingAvatarPicture = Image.asset(
      avatarPng,
      width: 40,
      height: 40,
    );

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset(
                "assets/svgs/arrow.svg",
                height: 20,
                colorFilter:
                    const ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
            ),
            centerTitle: true,
            title: Text(
              "Запись на тренировку",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                height: 22 / 18,
              ),
            )),
        backgroundColor: Colors.white,
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                HorizontalCard(
                  showTitle: true,
                  title: Text(
                    widget.item.name.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      height: 22 / 18,
                    ),
                  ),
                  showtags: true,
                  tags: tags(),
                  backgroundColor: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000), // Цвет тени с прозрачностью
                      offset: Offset(0, 0),
                      blurRadius: 4,
                      spreadRadius: 0,
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                HorizontalCard(
                    showLeadingVisuals: true,
                    leadingVisuals: leadingRecordSvg,
                    backgroundColor: const Color(0xFFF8F9FE),
                    title: Text(
                      "Идет запись",
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        height: 16 / 20,
                        color: const Color(0xFF1F2024),
                      ),
                    ),
                    showPreTrailingVisual: true,
                    preTrailingVisuals: richText()),
                const SizedBox(
                  height: 8,
                ),
                HorizontalCard(
                  leadingVisuals: leadingAvatarPicture,
                  showLeadingVisuals: true,
                  backgroundColor: const Color(0xFFF8F9FE),
                  title: Text(
                    widget.item.coachName,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      height: 16 / 20,
                      color: const Color(0xFF1F2024),
                    ),
                  ),
                  subtitle: Text(
                    "Крутой тренер",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 12 / 14,
                        color: const Color(0xFF71727A)),
                  ),
                  showSubtitle: true,
                  trailingControl: Transform.rotate(
                    angle:
                        3.14159, // Это значение соответствует 180 градусам в радианах
                    child: SvgPicture.asset(
                      "assets/svgs/arrow.svg",
                      height: 12,
                      colorFilter:
                          const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
                  ),
                  showTrailingControl: true,
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.all(16),
                  // TODO: Здесь должно быть описание item.
                  child: Text(
                    "С другой стороны постоянный количественный рост и сфера нашей активности требуют определения и уточнения дальнейших направлений развития. Значимость этих проблем настолько очевидна, что сложившаяся структура организации играет важную роль в формировании форм развития. Не следует, однако забывать, что начало повседневной работы по формированию позиции требуют от нас анализа дальнейших направлений развития. Разнообразный и богатый опыт новая модель организационной деятельности играет важную роль в формировании системы обучения кадров, соответствует насущным потребностям.",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      height: 18 / 14,
                    ),
                  ),
                ),
                const Spacer(),
                CustomButtonWidget(
                    variant: CustomButtonVariants.primary,
                    text:
                        isSignUpWillBeShown ? "ЗАПИСАТЬСЯ" : "Отменить запись",
                    textColor:
                        isSignUpWillBeShown ? Colors.white : Colors.black,
                    accentColor: isSignUpWillBeShown
                        ? const Color(0xFFA03FFF)
                        : const Color(0xFFF1EDF5),
                    onPressed: () => isSignUpWillBeShown
                        ? onSignUpPressed()
                        : onCancelRecordPressed())
              ],
            )));
  }

  Widget richText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text:
                '${widget.item.spots.maxSpots - widget.item.spots.currentSpots} мест\n', // widget.item.spots.maxSpots - widget.item.spots.currentSpots
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w800,
              height: 16.94 / 14,
            ),
          ),
          const TextSpan(
            text: 'осталось', // Второй стиль
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Inter', // Убедитесь, что шрифт подключен
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 14.52 / 12, // line-height / font-size
            ),
          ),
        ],
      ),
    );
  }

  List<CustomTag> tags() {
    return [
      if (isTomorrow(widget.item.dateDateTime))
        CustomTag(
          text: Text(
            "ЗАВТРА",
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w600, fontSize: 12, height: 16 / 12),
          ),
          disabledBackgroundColor: const Color(0xFFD6B5FF),
          showleftIcon: true,
          leftIcon: SvgPicture.asset("assets/svgs/calendar.svg"),
        ),
      CustomTag(
        text: Text(
          "${widget.item.timeStart}-${widget.item.endTime}",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600, fontSize: 12, height: 16 / 12),
        ),
        disabledBackgroundColor: const Color(0xFFD6B5FF),
        leftIcon: SvgPicture.asset("assets/svgs/time.svg"),
        showleftIcon: true,
      ),
      CustomTag(
        text: Text(
          "ЗАЛ 1",
          style: GoogleFonts.inter(
              fontWeight: FontWeight.w600, fontSize: 12, height: 16 / 12),
        ),
        showleftIcon: true,
        disabledBackgroundColor: const Color(0xFFD6B5FF),
        leftIcon: SvgPicture.asset("assets/svgs/dumbell.svg"),
      ),
    ];
  }

  bool isTomorrow(DateTime date) {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    return (tomorrow.year == date.year &&
        tomorrow.month == date.month &&
        tomorrow.day == date.day);
  }

  void onSignUpPressed() {
    _handleRecordAction(
      successMessage: "Вы записались на тренировку",
      successDescription:
          "${DateFormat('d MMMM', 'ru').format(widget.item.dateDateTime)} в ${widget.item.timeStart} ждем вас в клубе",
      status: "Подтвердил",
      isSignUp: true,
    );
  }

  void onCancelRecordPressed() {
    _handleRecordAction(
      successMessage: "Отменил",
      status: "Подтвердил",
      isSignUp: false,
    );
  }

  // TODO: Правильный номер телефона.
  void _handleRecordAction({
    required String successMessage,
    String? successDescription,
    required String status,
    required bool isSignUp,
  }) async {
    final result = await Api().singUpOrCancelRecord(
      "unknown",
      "79517710068",
      widget.item.gtoId,
      status,
      null,
    );

    if (result != null) {
      ToastManager().showToast(
        context,
        ToastWidget(
          variant: isSignUp ? ToastVariant.success : ToastVariant.warning,
          title: successMessage,
          showTitle: true,
          description: successDescription,
          showDescription: successDescription != null,
        ),
        ToastSide.bottom,
        left: 12,
        rigth: 12,
        bottom: 16,
      );

      setState(() {
        isSignUpWillBeShown = !isSignUp;
      });
    } else {
      showErrorToast();
    }
  }

  void showErrorToast() {
    ToastManager().showToast(
        context,
        const ToastWidget(
          variant: ToastVariant.error,
          title: "Ошибка!",
          showTitle: true,
          description: "Что-то пошло не так, попробуйте ещё раз..",
        ),
        ToastSide.bottom,
        left: 12,
        rigth: 12,
        bottom: 16);
  }
}
