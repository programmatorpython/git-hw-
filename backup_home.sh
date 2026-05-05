#!/bin/bash


SOURCE="$HOME/"
DEST="/tmp/backup"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
LOG_TAG="BACKUP_SCRIPT"


rsync -avzh --checksum --exclude=".*/" --delete --delete-excluded "$SOURCE" "$DEST" 2>&1 | logger -t "$LOG_TAG" -p user.info


if [ ${PIPESTATUS[0]} -eq 0 ]; then
    logger -t "$LOG_TAG" -p user.notice "Резервное копирование УСПЕШНО завершено. Время: $TIMESTAMP"
    exit 0
else
    logger -t "$LOG_TAG" -p user.err "Резервное копирование НЕ УДАЛОСЬ. Код ошибки: ${PIPESTATUS[0]}. Время: $TIMESTAMP"
    exit 1
fi