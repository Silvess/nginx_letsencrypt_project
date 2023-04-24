# Ansible роль для установки и конфигурирования Nginx

## Описание
С помощью представленного проекта можно произвести установку Nginx, изменение ряда параметров конфигурации, добавление варьируемого количества виртуальных хостов, получение и установку SSL-сертификатов для них, настроить автоматическое обновление сертификатов.

> На текущий момент реализована поддержка Ubuntu. Другие дистрибутивы не поддерживаются.

### Роль Nginx_setup_and_configure
Для использования роли необходимо задать переменную `virtual_hosts`. 
В ней указывается список виртуальных хостов и их параметры:
- `listen` - номер порта, на котором будет "отвечать" virtual host;
- `server_name` - имя/имена для обращения к виртуальному хосту;
- `index` - индексный файл (опционально). Если задано значение `index`, обязательно должно быть задано значение `root`.
- `index_template_path` - путь к шаблону индексного файла. По умолчанию, будет использоваться стандартный шаблон ***templates/index.html.j2***.
- `location` - (опционально). Может принимать несколько значений. В `name` указываем сам location (`location name { ... }`), в `content` - содержимое. Для многострочного ввода `content` можно воспользоваться конструкцией вида: 
``` 
content: | 
  line 1;
  line 2;
``` 
Пример задания переменной `virtual_hosts`:
```
virtual_hosts:
  - listen: 80
    server_name: example.com
    index: index.html
    location: 
      - name: '\'
        content: "try_files $uri $uri/ =404;"
```
Корневая директория для виртуальных хостов формируется по следующему принципу: путь в переменной `sites_root` + директория с именем виртуального хоста. Например, если `server_name` - examples.com, а значение переменной `sites_root: /var/www/`, то root сайта примет значение `/var/www/example.com/`.

Также есть возможность указать имя пакета для установки в переменной `package_name` (к примеру, если необходима определенная версия пакета):
```
package_name: nginx=1.18.0-0ubuntu1.4
```

Можно задать нужные значения некоторых параметров конфигурации вместо параметров по умолчанию:
```
worker_processes: auto
worker_connections: 768
keepalive_timeout: 60
```


### Роль Nginx_ssl_config
Для получения SSL-сертификатов используется модуль `acme_certificate`.



## Пример использования
```
---
- name: Install Nginx 
  hosts: all
  vars:
    virtual_hosts:
      - listen: 80
        server_name: site1.example.com
        index: index.html
        location: 
          - name: '\'
            content: "try_files $uri $uri/ =404;"
      - listen: 80
        server_name: site2.example.com
        index: index.html
        location: 
          - name: '\'
            content: "try_files $uri $uri/ =404;"

  roles:
    - { role: nginx_setup_and_configure, tags: 'setup' }
    - { role: nginx_ssl_config, tags: 'ssl' }
```

Также, пример использования приведен в плейбуке `nginx.yml`, вместе с созданием страниц-образцов для проверки работы создаваемых виртуальных хостов.
