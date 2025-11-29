## ------------------------
# Базовий образ Lampac (з Docker Hub)
# ------------------------
FROM yumata/lampac:latest

# ------------------------
# Встановлення git
# ------------------------
RUN apt-get update && \
    apt-get install -y git && \
    rm -rf /var/lib/apt/lists/*

# ------------------------
# Створення директорії для модулів
# ------------------------
RUN mkdir -p /home/module
WORKDIR /home/module

# ------------------------
# Клонування lampac-ukraine
# ------------------------
RUN git clone https://github.com/lampac-ukraine/lampac-ukraine.git

# ------------------------
# Створення repository.yaml
# ------------------------
RUN echo "- repository: https://github.com/lampame/lampac-ukraine\n  branch: main\n  modules:\n    - AnimeON\n    - Anihub\n    - Unimay\n    - CikavaIdeya\n    - Uaflix\n    - UaTUT" \
    > /home/module/repository.yaml

# ------------------------
# Виставлення порту
# ------------------------
EXPOSE 9118

# ------------------------
# Старт Lampac
# ------------------------
CMD ["lampac"]

