#!/bin/bash
EXPORT_DIR=${FIREBASE_EXPORT_DIR:-"/firebase/data"}

# Функция для обработки SIGTERM
sigterm_handler() {
  echo "SIGTERM received, gracefully shutting down Firebase Emulator"
  kill -TERM "$pid"  # Завершаем процесс эмулятора
  wait "$pid"  # Ждем завершения процесса
  echo "SIGTERM handled gracefully"
  exit 0
}
trap 'sigterm_handler' SIGTERM

# Функция для обработки SIGINT
sigint_handler() {
  echo "SIGINT received, gracefully shutting down Firebase Emulator"
  wait "$pid"  # Ждем завершения процесса
  echo "SIGINT handled gracefully"
  exit 0
}
trap 'sigint_handler' SIGINT

# Запуск Firebase Emulator в фоновом режиме
firebase emulators:start --import="$EXPORT_DIR" --export-on-exit="$EXPORT_DIR" & pid="$!"  # Сохраняем PID процесса эмулятора

# Ждем завершения эмулятора
wait "$pid"

# Запуск tail для того, чтобы контейнер не завершился сразу
tail -f /dev/null &

# Ожидание завершения всех процессов
wait $!
echo "Firebase Emulator has stopped."
exit 0
