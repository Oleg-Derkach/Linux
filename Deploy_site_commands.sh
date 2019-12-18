Использовать команды pip3  и python3


ssh root@121.22.23.152   Connecting to server via SSH Protocol
apt-get update
apt-get upgrade   update pocket base
perl -v   check the locale problems
при возникновении ошибок 'locales'
	locale-gen en_US en_US.UTF-8 ru_RU.UTF-8    
		устранение неполадок с кодировками, языковые стандарты 
		после нужно запустить команду 
	dpkg-reconfigure locales для применения изменений
perl -v     проверить на наличие ошибок 
apt-get install nginx   устанавливаем сервер nginx
	nginx   start server
	nginx -s reload  restart configuration
	nginx -s quit   exit server
	nginx -s stop  stop servver
apt-get install python3-dev python3-setuptools      install python libs
or easy_install-3.4 vertualenv    virtual environment instalator
or apt-get install virtualenv   -  virtual environment instalator

adduser django  -  creates new user    django(user)
user cofe pass 1

python3 -m pip install --upgrade pip
pip3 install vertualenv


virtualenv -p [/usr/bin/python3/path to python3!!!] venv[name_virt]   
	- create virtual environment using python3 with python3 as main interpreter !!!

source ../venv/bin/activate    -  activate the venv
		source /venv/bin/activate
ssh-keygen -t rsa -C "my_email@gmail.com"    generates the SSH keys
				on my remote server machine

Для того чтобы не искать в терминале ключи , можно добавить GUI
удаленный. Это будет папка линк между локальным компьютером и 
сервером
sshfs root@185.233.118.225:/ /home/pups/Downloads/RemoteMachine

	где root@185.233.118.225:/  это адрес нашего сервера
	/home/pups/Downloads/RemoteMachine - папка связи сервером
	вводим пароль от сервера
	umount /home/pups/Downloads/RemoteMachine   
	unmount remote machine                    размонтировать

находим публичный ключ в папке /root/.ssh/id_rsa.pub
копируем его содержимое
вставяем в гитхаб репозиторий новый SSH ключ

git clone https://github.com/...   clone the project
pip3 install uwsgi   - for connect django project with web server
Создаем новый файл test.py для проверки нашего uwsgi

def application(env, start_response):
    start_response('200 OK', [('Content-Type','text/html')])
    return [b"Hello World"]

uwsgi --http :8000 --wsgi-file test.py  заходим на наш IP port 8000
и если ве норм то мы видим Hello World

==================================================
# Instalation pocket for work with PostgreSQL
apt-get install libpq-dev postgresql postgresql-contrib   install package for work
 	with postgresql
su - postgres       enter to postgres
createdb my_site    create db
createyser -P django   create user
psql  enter to dbase
postgres=  GRANT ALL PRIVILEGES ON DATABASE my_site TO django;
Give all permisions to user
pip install psycopg2   - install config driver for database postgresql
change data in settings py, regarding database

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycorg2',
        'NAME': 'my_site', # filename of db
        'USER': 'django',
        'PASSWORD': '12124523',
        'HOST': 'loaclhost',
        'PORT': '', }}

Configurate the static files root. As example

STATIC_URL = '/static/'
STATICFILES_DIRS = (os.path.join(BASE_DIR, "static", "static_dev"),)

MEDIA_URL = '/media/'
MEDIA_ROOT = os.path.join(BASE_DIR, "static", "media")

Для того чтобы привязать nginx к статическим файлам проекта
нужно указать STATIC_ROOT папку в сетингс.пу
STATIC_ROOT = os.path.join(BASE_DIR, "static", "static_prod")

python3 manage.py collectstatic   сохраняем статику в назначеный 
	папку "static", "static_prod"
197 static files copied to '/home/django/Kofee_shop/static/static_prod'

Пробуем запустить сервер 

uwsgi --http :8000 --wsgi-file Kofee_shop/wsgi.py

Kofee_shop/wsgi.py - это путь к файлу wsgi приложения. Походу как точка
входа в приложение, после выполнения команды должен запустится сервер
и не выдавать ошибок.

===================================================
Nginx
Далее необходимо сконфигурировать nginx
Создаем папку с файлами Deployment
В ней создаем файл с параметрами для uwsgi

	uwsgi_param  QUERY_STRING       $query_string;
	uwsgi_param  REQUEST_METHOD     $request_method;
	uwsgi_param  CONTENT_TYPE       $content_type;
	uwsgi_param  CONTENT_LENGTH     $content_length;

	uwsgi_param  REQUEST_URI        $request_uri;
	uwsgi_param  PATH_INFO          $document_uri;
	uwsgi_param  DOCUMENT_ROOT      $document_root;
	uwsgi_param  SERVER_PROTOCOL    $server_protocol;
	uwsgi_param  REQUEST_SCHEME     $scheme;
	uwsgi_param  HTTPS              $https if_not_empty;

	uwsgi_param  REMOTE_ADDR        $remote_addr;
	uwsgi_param  REMOTE_PORT        $remote_port;
	uwsgi_param  SERVER_PORT        $server_port;
	uwsgi_param  SERVER_NAME        $server_name;

далее создаем файл и указываем пути к статике, имя нашего сайта,
расположение нашего файла конфигурации. Здесь нужно очень внимательно
все заполнить. 
! Для того чтобы доступ осуществлялся по IP адресу или названию
без указания конкретного порта нужно в строчке Server {listen  вместо 8000
 указать 80}

	# the upstream component nginx needs to connect to
	upstream django {
	    server unix:///home/django/my_site/uwsgi_nginx.sock; # for a file socket
	    # server 127.0.0.1:8001; # for a web port socket (we'll use this first)
	}

	# configuration of the server
	server {
	    # the port your site will be served on
	    # listen      8000;
	    listen      80;
	    # the domain name it will serve for
	    server_name my_site.ru; # substitute your machine's IP address or FQDN
	    charset     utf-8;

	    # max upload size
	    client_max_body_size 75M;   # adjust to taste

	    # Django media
	    location /media  {
		alias /home/django/my_site/media;  # your Django project's media files - amend as required
	    }

	    location /static {
		alias /home/django/my_site/static; # your Django project's static files - amend as required
	    }

	    # Finally, send all non-media requests to the Django server.
	    location / {
		uwsgi_pass  django;
		include     /home/django/my_site/deployment/uwsgi_params; # the uwsgi_params file you installed
	    }
	}

Делаем ссылку на нашу конфигурационный файл в папке 
ln -s /home/django/Kofee_shop/Deployment/Kofee_shop_nginx.conf /etc/nginx/sites-enabled

Перезапускаем nginx
/etc/init.d/nginx restart

Помещаем файл с картинкой, например, media.png в папку /home/django/my_site/media.

В браузере переходим по адресу yourserver.com:8000/media/media.png и, если видим наш файл, 
значит мы все сделали правильно.

Пробуем запустить через сокет:
	 uwsgi --socket uwsgi_nginx.sock --module Kofee_shop.wsgi --chmod-socket=666
Сервер должен запустится без ошибок

создаем конфигурационный файл для запуска в корневой  kofee.ini
	#mysite_uwsgi.ini 
	[uwsgi]

	# Настройки, связанные с Django
	# Корневая папка проекта (полный путь)
	chdir           = /home/django/my_site
	# Django wsgi файл
	module          = my_site.wsgi
	# полный путь к виртуальному окружению
	home            = /home/django/venv
	# общие настройки
	# master
	master          = true
	# максимальное количество процессов
	processes       = 10
	# полный путь к файлу сокета
	socket          = /home/django/my_site/uwsgi_nginx.sock
	# права доступа к файлу сокета
	chmod-socket    = 666
	# очищать окружение от служебных файлов uwsgi по завершению
	vacuum          = true

Проверяем запуском команды из папки проекта uwsgi --ini kofee.ini
Все должно работать !

выходим из вертуального окружения и устанавиваем пакеты глобально
apt-get install python-pip python3-pip
pip3 install uwsgi

66. Если сервер обслуживает несколько проектов, каждый из которых использует uWSGI, 
то нужно исползовать режим Emperor. В этом режиме uWSGI просматривает папку с 
конфигурационными файлами и для каждого файла запускает отдельный процесс (вассал).
Если один из конфигурационных файлов будет изменен, uWSGI перезапустит 
соответствующего вассала.

Создаем папку для конфигурационных файлов:

	sudo mkdir /etc/uwsgi
	sudo mkdir /etc/uwsgi/vassals

Отдельный вассал это отдельные настройки сервера .ini таких как был создан ранее (kofee.ini)
Проще говоря это отдельный проект, их может быть несколько

Создаем ссылку из /etc/uwsgi/vassals/  в папку с проектом на ини  файл 
ln -s /home/django/Kofee_shop/Deployment/kofee.ini /etc/uwsgi/vassals/

Запускаем uWSGI в режиме Emperor, потом отключаем если все хорошо
(Возможно вам придется перезапустить вашу БД такой командой sudo service 
	postgresql restart):

	uwsgi --emperor "/home/django/Kofee_shop/Deployment/my_site_uwsgi.ini"

Устанавливаем супервизордля того чтобы сайт работал автономно
	apt-get install supervisor

Создаем файл конфигурации в папке etc/supervisor/conf.d/kofee_conf.conf:
	echo_supervisord_conf > /etc/supervisord.conf
Этот файл будет определять поведение сайта 

В Этом файле указываем следующий текст:
	
	[program:my_site]
	command=uwsgi --emperor "/home/django/my_site/deployment/my_site_uwsgi.ini"
	stdout_logfile=/home/django/my_site/deployment/uwsgi.log
	stderr_logfile=/home/django/my_site/deployment/uwsgi_err.log
	autostart=true
	autorestart=true

Перезагружаем супервизора  
	service supervisor restart

Индексируем этот файл: (Если появляются какие то ошибки, перезапускаем supervisor(service supervisor restart)) Так же, смотрим логи.

	supervisorctl reread
	supervisorctl update

После этого сайт должен работать автономно, проверять статус работы можно
командами 
service supervisor start|stop|status ..

После измениений внесенных в конфигурации необходимо:
1. Остановить 					supervisor stop
2. Перезапускать NGINX 			service nginx restart
3. Запускаем супервизор         supervisor start

При изменеии в структуру приложения , например изменили DEBUG = True / False
1. Остановить супервизора                      	supervisor stop
2. Зделать touch конфигурационного файла  		touch kofee.ini
3. Снова запустить супервизора  				supervisor start





     


