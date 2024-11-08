import os
 #code system
def get_directory_size(path='.'):
    total_size = 0
    file_sizes = {}

    # Проход по всем файлам и папкам в указанной директории

    for dirpath, dirnames, filenames in os.walk(path):
        for filename in filenames:
            file_path = os.path.join(dirpath, filename)
            try:
                file_size = os.path.getsize(file_path)
                total_size += file_size
                file_sizes[file_path] = file_size
            except OSError as e:
                print(f"Ошибка доступа к файлу {file_path}: {e}")

    return total_size, file_sizes

def format_size(size):
    # Форматирование размера в удобочитаемый вид

    for unit in ['Б', 'КБ', 'МБ', 'ГБ']:
        if size < 1024:
            return f"{size:.2f} {unit}"
        size /= 1024

def main():
    directory_path = '.'  # Текущая директория
    total_size, file_sizes = get_directory_size(directory_path)

    print(f"Размер текущей директории '{directory_path}': {format_size(total_size)}")
    print("\nРазмеры файлов:")
    for file_path, size in file_sizes.items():
        print(f"{file_path}: {format_size(size)}")
#
if __name__ == "__main__":
    main()
