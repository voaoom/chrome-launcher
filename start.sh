#!/bin/bash
#
# Google Chrome	46.0.2490.86
# Blink	537.36
# JavaScript	V8 4.6.85.31
# Flash	19.0.0.245
#
# Chromium	45.0.2454.101
# Blink	537.36
# JavaScript	V8 4.5.103.35
# Flash	11.2.999.999

cd "$(dirname "$0")"

# Defaults
browser='google-chrome-stable'
# browser='chromium-browser'
user="$USER"

while [[ $# > 0 ]]; do
	arg="$1"
	shift
	[ "$arg" == '@' ] && break
	echo "Evaluating: [ $arg ]"
	eval "$arg"
done

# Forced
data_dir=$(dirname "$0")
args=''
fieldtrials=''

function push_arg() {
	args="$args $@"
}

# chrome://flags
# https://code.google.com/p/chromium/codesearch#chromium/src/chrome/browser/about_flags.cc
function push_fieldtrial() {
	fieldtrials="${fieldtrials}${1}/${2}/"
}

# # sturtup & shutdown settings # # #

	# Disables the default browser check.
push_arg '--no-default-browser-check'
	# If this flag is present then this command line is being delegated to an already running chrome process via the fast path, ie: before chrome.dll is loaded.
push_arg '--fast-start'
	# Skip First Run tasks, whether or not it's actually the First Run.
push_arg '--no-first-run'
	# Быстрое закрытие окон и вкладок – JS-обработчик "onunload" для вкладки выполняется независимо от интерфейса пользователя
push_arg '--enable-fast-unload'
	# Makes component extensions appear in chrome://settings/extensions.
push_arg '--show-component-extension-options'
	# Runs a single process for each site (i.e., group of pages from the same registered domain) the user visits.
push_arg '--process-per-site'


# # # networking settings # # #

	# Обеспечивает отправку дополнительных данных аутентификации в исходном SYN-пакете подключенного клиента, благодаря чему ускоряется обмен данными.
push_arg '--enable-tcp-fastopen'
	# Disables the crash reporting.
push_arg '--disable-breakpad'
	# Disable speculative TCP/IP preconnection
push_arg '--disable-preconnect'
	# Отключение отсылки запросов для проверки гиперссылок
push_arg '--disable-hyperlink-auditing'
	# Оповещения об обнаружении устройств в локальной сети.
push_arg '--enable-device-discovery-notifications'
	# Если на странице не задана четкая политика относительно источника ссылки, при установке этого флага в заголовке referer для встречных запросов будет содержаться меньше информации.
push_arg '--reduced-referrer-granularity'
	# Разрешать отправлять запросы на сервер localhost, даже если представлен недействительный сертификат.
push_arg '--allow-insecure-localhost'


# # # graphics & render settings # # #

	# Переопределяет встроенный список программного рендеринга и активирует графический ускоритель на неподдерживаемых системах.
push_arg '--ignore-gpu-blacklist'
	# Если включить эту функцию, веб-приложениям будет предоставлен доступ к разрабатываемым расширениям WebGL.
push_arg '--enable-webgl-draft-extensions'
	# Enables WebGL rendering into a scanout buffer for overlay support.
push_arg '--enable-webgl-image-chromium'
	# Включить экспериментальную плавную прокрутку
push_arg '--enable-smooth-scrolling'
	# Enable accelerated 2D canvas.
push_arg '--enable-accelerated-2d-canvas'
	# When using CPU rasterizing generate low resolution tiling.
push_arg '--disable-low-res-tiling'
	# Обозначает параметр качества изображений, полученных при уменьшении масштаба.
push_arg '--tab-capture-downscale-quality=fast'
	# Обозначает параметр качества изображений, полученных при увеличении масштаба.
push_arg '--tab-capture-upscale-quality=fast'
	# Уменьшить приоритет загрузки для ресурсов iframe.
push_arg '--blink-settings=lowPriorityIframes=true'
	# Позволяет использовать разрабатываемые экспериментальные функции canvas.
push_arg '--enable-experimental-canvas-features'
	# Enables LCD text.
push_arg '--enable-lcd-text'


# # # passwords & auth # # #

	# Cохранять пароли автоматическ
push_arg '--enable-automatic-password-saving'
	# Пользователь может разрешить Chrome создавать пароли на страницах регистрации аккаунтов
push_arg '--enable-password-generation=enabled'
	# Показывать на странице настроек диспетчера паролей ссылку для онлайн-управления паролями синхронизации
push_arg '--enable-password-link=enabled'
	# Предлагает варианты автозаполнения при нажатии кнопкой мыши на элемент формы.
push_arg '--enable-single-click-autofill'
	# Ignores autocomplete="off" for Autofill data (profiles + credit cards).
push_arg '--ignore-autocomplete-off-autofill'
	# Заполняет пароли не автоматически при загрузке страницы, а при выборе пользователем нужного аккаунта.
push_arg '--enable-fill-on-account-select'
	# Показывать на странице настроек диспетчера паролей ссылку для онлайн-управления паролями синхронизации.
push_fieldtrial 'PasswordLinkInSettings' 'Enabled'


# # # features & UI settings # # #

	# Starts the browser maximized, regardless of any previous settings.
push_arg '--start-maximized'
	# The language file that we want to try to open. Of the form language[-country] where language is the 2 letter code from ISO-639.
push_arg '--lang=ru'
	# Enables multiple account versions of chrome.identity APIs.
push_arg '--extensions-multi-account'
	# Disables safebrowsing feature that checks download url and downloads content's hash to make sure the content are not malicious.
push_arg '--safebrowsing-disable-download-protection'
	# Disables safebrowsing feature that checks for blacklisted extensions.
push_arg '--safebrowsing-disable-extension-blacklist'
	# Enable spatial navigation
push_arg '--enable-spatial-navigation'
	# Позволяет проверять правописание на нескольких языках сразу
push_arg '--enable-multilingual-spellchecker'
	# Enables the tab switcher.
push_arg '--enable-tab-switcher'
	# Enable the accessibility tab switcher.
push_arg '--enable-accessibility-tab-switcher'
	# Разрешить возобновление или повторное скачивание файлов через контекстное меню "Возобновить"
push_arg '--enable-download-resumption'
	# Показывает состояние скачивания в виде оповещения, а не объекта на соответствующей панели
push_arg '--enable-download-notification=enabled'
	# Предсказывает движения пальцев при прокрутке, что позволяет заранее обрабатывать фреймы
push_arg '--enable-scroll-prediction'
	# Обеспечивает перемещение по истории просмотра при достижении конца горизонтальной прокрутки
push_arg '--overscroll-history-navigation=enabled'
	# Разрешает использование папки с управляемыми закладками для контролируемых профилей
push_arg '--enable-supervised-user-managed-bookmarks-folder'
	# Страницы, не загруженные из-за отсутствия интернет-подключения, будут автоматически перезагружены, только если вкладка активна. 
push_arg '--enable-offline-auto-reload-visible'
push_arg '--enable-offline-auto-reload-visible-only'
	# Определять управляемые аккаунты при входе и запуске и периодически их проверять
push_arg '--enable-child-account-detection'
	# Включить новую систему управления профилями, в том числе функцию блокировки профиля и новый интерфейс выбора аватара.
push_arg '--new-profile-management'
	# Включить экспериментальные инструменты разработчика. 
push_arg '--enable-devtools-experiments'
	# Включить новое экспериментальное оформление панели инструментов расширений.
push_arg '--enable-extension-action-redesign'
	# Отключение и включение звука при помощи аудиоиндикаторов на панели вкладок, а также добавление в контекстное меню команд для отключения звука на выбранных вкладках.
push_arg '--enable-tab-audio-muting'
	# В подсказках омнибокса названия сайтов будут выделены.
push_arg '--emphasize-titles-in-omnibox-dropdown'
	# Показывает счетчики объема данных в диалоговом окне "Удалить данные браузера". 
push_arg '--enable-clear-browsing-data-counters'
	# Разрешить использование имени профиля и значка из аккаунта Google в меню выбора аватара.
push_arg '--google-profile-info'
	# Предоставляет браузеру Chrome доступ к внешним дисплеям для презентаций и разрешает показывать на них веб-контент.
push_arg '--enable-media-router'
	# При ошибке загрузки страницы показывать кнопку, с помощью которой можно загрузить неактивную локальную копию, если она сохранена в кеше браузера.
	# Если сделать кнопку основной, она будет располагаться на самом видном месте страницы ошибки, а если второстепенной – то рядом с кнопкой перезагрузки.
push_arg '--show-saved-copy=primary'
	# Позволяет выбрать режим кеширования для V8 (движка JavaScript).
push_arg '--v8-cache-options=code'
	# Allows the ErrorConsole to collect runtime and manifest errors, and display them in the chrome:extensions page.
push_arg '--error-console'


# # # user profile settings # # #

	# Specifies which password store to use (detect, default, gnome, kwallet).
push_arg '--password-store=default'
	# Specifies the user data directory. This is the one directory which stores all persistent data.
push_arg "--user-data-dir=\"$data_dir\""
	# Specifies the path to the user data folder for the parent profile
push_arg '--parent-profile="Default"'
	# Selects directory of profile to associate with the first browser launched. 
push_arg "--profile-directory=\"$user\""


# # # Field Trials # # #

push_arg "--fieldtrials=${fieldtrials}"

# # # custom arguments # # #

while [[ $# > 0 ]]; do
	push_arg "$(printf "%q" "$1")"
	shift
done
echo "Custom args: [ $args ]"

# Start browser
eval nice -n 5 ionice -c 3 -t $browser $args & exit 0
