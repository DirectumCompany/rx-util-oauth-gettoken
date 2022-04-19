<#
Версии Powershell: 5.1, 7.0, 7.1, 7.2

Пример параметров приложения Yandex для отправки почты:
    Права:
        Отправка писем через Яндекс.Почту по протоколу SMTP

    ID: ################################
    Пароль: ################################
    Callback URL: https://oauth.yandex.ru/verification_code
    Время жизни токена: Не менее, чем 1 год
    Дата создания: ##.##.##
#>

# Идентификатор приложения Yandex.
$clientId = Read-Host -Prompt "Client Id"
# Пароль приложения Yandex.
$clientSecret = Read-Host -Prompt "Client secret" -AsSecureString

# Запросим код подтверждения у пользователя через браузер по-умолчанию.
Start-Process "https://oauth.yandex.ru/authorize?response_type=code&client_id=$clientId"

# Попросим ввести код подтверждения, который был получен в браузере.
$verificationCode = Read-Host -Prompt "Verification code"

# Обменяем код подтверждения на токен.
$credential = [System.Net.NetworkCredential]::new($clientId, $clientSecret)
$tokenResponseBody = @{ grant_type='authorization_code'; code=$verificationCode; client_id=$credential.UserName; client_secret=$credential.Password }
$tokenResponse = Invoke-WebRequest -Uri "https://oauth.yandex.ru/token" -Method Post -Body $tokenResponseBody
if ($tokenResponse.StatusCode -eq 200) {
    $tokenResponse.Content | ConvertFrom-Json | Format-List
}
else {
    Write-Host $tokenResponse
}
