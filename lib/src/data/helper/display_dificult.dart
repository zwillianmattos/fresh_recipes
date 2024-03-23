displayDificult(dificult) {
  switch (dificult) {
    case '1':
      return 'Easy';
    case '2':
      return 'Medium';
    case '3':
      return 'Hard';
    default:
      return '-';
  }
}

String formatarTempoEmMinutos(DateTime tempo) {
  int minutosTotais = tempo.hour * 60 + tempo.minute;

  int horas = minutosTotais ~/ 60;
  int minutos = minutosTotais % 60;

  if (horas > 0 && minutos > 0) {
    return '$horas h $minutos min';
  } else if (horas > 0) {
    return '$horas h';
  } else {
    return '$minutos min';
  }
}
