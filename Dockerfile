FROM mcr.microsoft.com/dotnet/sdk:6.0-alpine as build-env
WORKDIR /src
COPY GraphSPARQL.csproj .
RUN dotnet restore
COPY src .
RUN dotnet publish -c Release -o /publish

FROM mcr.microsoft.com/dotnet/aspnet:6.0-alpine as runtime
WORKDIR /publish
COPY --from=build-env /publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "GraphSPARQL.dll"]
