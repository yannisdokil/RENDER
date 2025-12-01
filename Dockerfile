# ---------------------------
# 1. Базовий образ із .NET
# ---------------------------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /app

# ---------------------------
# 2. Клонування Lampac
# ---------------------------
RUN git clone https://github.com/lampame/lampac.git .

# ---------------------------
# 3. Збірка Lampac
# ---------------------------
RUN dotnet publish Lampac.csproj -c Release -o /publish


# ---------------------------
# 4. Фінальний образ
# ---------------------------
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final

WORKDIR /app

# Копіюємо зібраний Lampac
COPY --from=build /publish /app


# ---------------------------
# 5. Автовстановлення українських модулів
# ---------------------------
RUN apt-get update && apt-get install -y git && \
    git clone https://github.com/lampac-ukraine/lampac-ukraine.git /tmp/modules && \
    mkdir -p /app/module && \
    cp -r /tmp/modules/* /app/module/ && \
    rm -rf /tmp/modules


# ---------------------------
# 6. Порт Lampac
# ---------------------------
EXPOSE 8080

ENV ASPNETCORE_URLS=http://0.0.0.0:8080

# ---------------------------
# 7. Запуск Lampac
# ---------------------------
ENTRYPOINT ["dotnet", "Lampac.dll"]
