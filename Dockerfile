# ----------------------------
# 1) Build stage (.NET SDK)
# ----------------------------
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

WORKDIR /src

# Завантажуємо Lampac zip (Render-friendly)
ADD https://github.com/lampame/lampac/archive/refs/heads/main.zip lampac.zip

RUN apt-get update && apt-get install -y unzip && \
    unzip lampac.zip && \
    mv lampac-main lampac && \
    cd lampac && dotnet publish Lampac.csproj -c Release -o /publish


# ----------------------------
# 2) Runtime stage (ASP.NET 8)
# ----------------------------
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final

WORKDIR /app

# копіюємо зібрану програму Lampac
COPY --from=build /publish /app/

# git потрібен для модулів
RUN apt-get update && apt-get install -y git && apt-get clean

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080
ENV ASPNETCORE_URLS=http://0.0.0.0:8080

ENTRYPOINT ["/app/start.sh"]
