FROM microsoft/dotnet:sdk AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.2-sdk-nanoserver-1809 AS build
WORKDIR /src
COPY ["*", "TestService/"]
RUN dotnet restore "TestService/TestService.csproj"
COPY . .
WORKDIR "/src/TestService"
RUN dotnet build "TestService.csproj" -c Debug -o /app

FROM build AS publish
RUN dotnet publish "TestService.csproj" -c Debug -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "TestService.dll"]