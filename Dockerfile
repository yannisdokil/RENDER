FROM ubuntu:22.04

# ----------- БАЗОВАЯ СИСТЕМА -----------
RUN apt update && apt install -y \
    bash \
    curl \
    git \
    wget \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ----------- КЛОНИРОВАНИЕ ПРОЕКТА RENDER -----------
RUN git clone https://github.com/yannisdokil/RENDER /app
WORKDIR /app

# ----------- ПРАВА НА СКРИПТЫ -----------
RUN chmod -R +x .

# ----------- ПЕРЕМЕННАЯ ДЛЯ ВЫБОРА СЕРВИСА -----------
ENV SERVICE=lampac

# ----------- ПОРТ ПО УМОЛЧАНИЮ (ПОТОМ МОЖНО ПЕРЕОПРЕДЕЛЯТЬ В KOYEB) -----------
EXPOSE 9999

# ----------- ЗАПУСК ЛЮБОГО СЕРВИСА ИЗ ПРОЕКТА -----------
CMD bash Build/Linux/install.sh "$SERVICE" && bash "$SERVICE/start.sh"
