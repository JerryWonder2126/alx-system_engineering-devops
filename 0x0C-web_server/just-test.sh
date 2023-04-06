#!/usr/bin/env bash

sed 'N;/server_name/a # Redirect configuration\n\tlocation \/redirect_me {\n\t\thttps:\/\/youtube.com redirect\n\t}\n' /etc/nginx/sites-available/site.config
