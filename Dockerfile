FROM microsoft/windowsservercore
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]
RUN Invoke-WebRequest -OutFile c:\SQLToolbeltEssentials.exe -Uri https://download.red-gate.com/SQLToolbeltEssentials.exe
RUN Invoke-Expression 'SQLToolbeltEssentials.exe extract ".\Redgate installers"'

ADD . .
WORKDIR /Redgate Installers/SQL Compare 12.2.1.4077
RUN & cmd /S /C msiexec /i 'SQL Compare_12.2.1.4077_x86.msi' /t 'SQL Compare_12.2.1.4077_x86.mst' /qn /l install.log

WORKDIR /
RUN Remove-Item -Path '.\Redgate Installers\' -Force -Recurse
CMD ["powershell"]
