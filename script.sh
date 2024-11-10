#!/bin/bash
# Функция для получения размера каталога
get_size() {
    local path="$1"
    local size=$(du -hs "$path" 2>/dev/null | cut -f1)
    echo $size
}
# Проверка на наличие параметра
if [ $# -eq 0 ]; then
    echo "Укажите каталог для сканирования."
    exit 1
fi
# Путь к каталогу из переданного аргумента
dir_to_scan="$1"
# Проверка существования каталога
if [ ! -d "$dir_to_scan" ]; then
    echo "Каталог '$dir_to_scan' не существует."
    exit 1
fi
# Массив для хранения размеров подкаталогов
declare -A sizes
# Получаем размеры всех подкаталогов в указанном каталоге
for path in "$dir_to_scan"/*; do
    if [ -d "$path" ]; then
        size=$(get_size "$path")
        sizes["$path"]=$size
    fi
done
# Сортировка по убыванию размера
sorted_dirs=($(for dir in "${!sizes[@]}"; do
                  echo "${sizes[$dir]} $dir"
                done | sort -rh))
# Форматирование и вывод результата
echo "Список подкаталогов в '$dir_to_scan', отсортированный по размеру:"
for entry in "${sorted_dirs[@]}"; do
    size=$(echo $entry | awk '{print $1}')
    path=$(echo $entry | awk '{$1=""; print $0}' | xargs)
    echo "$size KB - $path"
done
