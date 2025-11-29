# Базовий образ Lampac
FROM immisterio/lampac:latest

# Встановлюємо unzip (якщо потрібно для модулів)
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# Папка для модулів
WORKDIR /home/module

# Копіюємо українські модулі
COPY lampac-ukraine ./lampac-ukraine

# Створюємо repository.yaml для Lampac
COPY repository.yaml ./repository.yaml

# Прокидуємо порт
EXPOSE 9118

# Старт Lampac
CMD ["lampac"]
