FROM mcr.microsoft.com/dotnet/sdk:8.0

WORKDIR /app

RUN apt-get update && apt-get install -y git unzip wget && apt-get clean

COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

EXPOSE 8080
ENV ASPNETCORE_URLS=http://0.0.0.0:8080

ENTRYPOINT ["/app/start.sh"]
