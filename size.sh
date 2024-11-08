#!/bin/bash

# Функция для получения размеров файлов и каталогов
get_size() {
    local path="$1"
    local size=$(du -hs "$path" 2>/dev/null | awk '{print $1}')
    echo "$size"
}

# Получаем содержимое домашней директории
home_dir="$ROOT"
result=()

# Сканируем домашнюю директорию
for item in "$home_dir"/*; do
    if [ -e "$item" ]; then  # Проверка существования
        size=$(get_size "$item")
        result+=("$size $item")
    fi
done

# Сортируем по убыванию и выводим 5 крупнейших элементов
IFS=$'\n' sorted=($(sort -hr <<<"${result[*]}")); unset IFS

# Выводим только первые 5 элементов
count=0
for item in "${sorted[@]}"; do
    if [[ $count -lt 5 ]]; then
        echo "$item"
        count=$((count + 1))
    else
        break
    fi
done