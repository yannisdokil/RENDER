FROM immisterio/lampac:latest
RUN apt-get update && apt-get install -y unzip && rm -rf /var/lib/apt/lists/*

# Копіюємо модулі у контейнер
WORKDIR /home/module
COPY lampac-ukraine-main ./lampac-ukraine

# Створюємо repository.yaml
RUN echo "- repository: ./lampac-ukraine\n  branch: main\n  modules:\n    - AnimeON\n    - Anihub\n    - Unimay\n    - CikavaIdeya\n    - Uaflix\n    - UaTUT" > /home/module/repository.yaml

EXPOSE 9118
CMD ["lampac"]
