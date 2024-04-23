#!/bin/bash
# Указываем интерпретатор
if [ $# -ne 2 ]; then
    echo "Использование: $0 Входная_директория Выходная_директория"
    exit 1
fi

dir1="$1"
dir2="$2"
# Считываем вход и выход
if [ ! -d "$dir1" ]; then
    echo "No such directory: $dir1"
    exit 1
fi

mkdir -p "$dir2"
# Смотрим, есть ли такие вообще
files=$(find "$dir1" -maxdepth 1 -type f)
echo "Файлы на входе"
echo "$files"
echo ""

directories=$(find "$dir1" -maxdepth 1 -type d)
echo "Папки на входе"
echo "$directories"
echo ""

all_files=$(find "$dir1" -type f)
echo "Все файлы"
echo "$all_files"
echo ""
# Получаем все, что нужно было
find "$dir1" -type f | while read file; do
    file_to_copy=$(basename "$file")
    if [ -e "$dir2/$file_to_copy" ]; then
        file_to_copy="${file_to_copy%.*}_$(date +%s%N).${file_to_copy##*.}"
    fi
    cp "$file" "$dir2/$file_to_copy"
done

echo "Ready"
