# Використовуємо існуючий образ Lampac з Docker Hub
FROM immisterio/lampac:latest

# Встановлюємо git, щоби можна було клонувати модулі
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Створюємо папку для модулів
RUN mkdir -p /home/module
WORKDIR /home/module

# Клонуємо український набір модулів
RUN git clone https://github.com/lampac-ukraine/lampac-ukraine.git

# Створюємо repository.yaml для підключення модулів
RUN echo "- repository: https://github.com/lampame/lampac-ukraine\n  branch: main\n  modules:\n    - AnimeON\n    - Anihub\n    - Unimay\n    - CikavaIdeya\n    - Uaflix\n    - UaTUT" \
    > /home/module/repository.yaml

# Прокидуємо порт, на якому Lampac слухає
EXPOSE 9118

# Запуск Lampac
CMD ["lampac"]
