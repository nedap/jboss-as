@echo off
SETLOCAL

rem Author: Gregory Charles, JBoss Community Member
rem Date: January 24, 2012

set DIRNAME="%~dp0"
call :DeQuote DIRNAME
set PROGNAME=%0

rem Setup JBOSS_HOME
set JBOSS_HOME=%DIRNAME%\..

rem Setup the JVM
IF NOT DEFINED JAVA (
    IF DEFINED JAVA_HOME (
        set JAVA="%JAVA_HOME%\bin\java"
    ) ELSE (
        JAVA=java
    )

)

IF NOT DEFINED MODULEPATH (
    set MODULEPATH="%JBOSS_HOME%\modules"
	call :DeQuote MODULEPATH
)

rem 
rem Setup the JBoss Vault Tool classpath
rem

rem Shared libs
set JBOSS_VAULT_CLASSPATH="%MODULEPATH%\org\picketbox\main\*"
set JBOSS_VAULT_CLASSPATH=%JBOSS_VAULT_CLASSPATH%;"%MODULEPATH%\org\jboss\logging\main\*"
set JBOSS_VAULT_CLASSPATH=%JBOSS_VAULT_CLASSPATH%;"%MODULEPATH%\org\jboss\common-core\main\*"
set JBOSS_VAULT_CLASSPATH=%JBOSS_VAULT_CLASSPATH%;"%MODULEPATH%\org\jboss\as\security\main\*"
set JBOSS_VAULT_CLASSPATH=%JBOSS_VAULT_CLASSPATH%;"%MODULEPATH%\org\apache\commons\cli\main\*"


rem Display our environment
echo =========================================================================
echo.
echo   JBoss Vault
echo.
echo   JBOSS_HOME: %JBOSS_HOME%
echo.
echo   JAVA: %JAVA%
echo.
echo   VAULT Classpath: %JBOSS_VAULT_CLASSPATH%
echo =========================================================================
echo.

%JAVA% -classpath %JBOSS_VAULT_CLASSPATH% org.jboss.as.security.vault.VaultTool %*

ENDLOCAL

:END
goto :EOF

:DeQuote
for /f "delims=" %%A in ('echo %%%1%%') do set %1=%%~A
goto :EOF

:EOF
