FROM mcr.microsoft.com/dotnet/aspnet:6.0

WORKDIR /usr/local/app/

RUN apt-get update \
    && apt-get install -y curl libsnappy-dev libc-dev libc6-dev libc6 unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ADD x42.Node-1.1.29-linux-x64.tar.gz . 

ENTRYPOINT ["dotnet", "x42.xServerD.dll"]