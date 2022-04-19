#!/bin/bash
: '
Пример параметров приложения Yandex для отправки почты:
    Права:
        Отправка писем через Яндекс.Почту по протоколу SMTP

    ID: ################################
    Пароль: ################################
    Callback URL: https://oauth.yandex.ru/verification_code
    Время жизни токена: Не менее, чем 1 год
    Дата создания: ##.##.##
'

# Идентификатор приложения Yandex.
echo "Client Id"
read clientId

# Пароль приложения Yandex.
echo "Client secret"
read -s clientSecret

# Запросим код подтверждения у пользователя через браузер.
echo
echo "Open the link to get the verification code:"
echo "https://oauth.yandex.ru/authorize?response_type=code&client_id=$clientId"
echo

# Попросим ввести код подтверждения, который был получен в браузере.
echo "Verification code"
read verificationCode

# Обменяем код подтверждения на токен.
echo
curl -w "\nType: %{content_type}\nCode: %{response_code}\n" -X POST 'https://oauth.yandex.ru/token' -d "grant_type=authorization_code&code=$verificationCode&client_id=$clientId&client_secret=$clientSecret"
echo
