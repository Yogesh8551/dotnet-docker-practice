FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build

WORKDIR /src

COPY automation.csproj ./

RUN dotnet restore ./automation.csproj

COPY . .

RUN dotnet publish ./automation.csproj -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime

WORKDIR /app

COPY --from=build /app .

ENV ASPNETCORE_URLS=http://0.0.0.0:80

EXPOSE 80

ENTRYPOINT ["dotnet", "automation.dll"]

