#!/bin/bash

rm -f ~/.bashrc

echo 'clear' >> ~/.bashrc
echo 'echo -e "\e[1;31m"' >> ~/.bashrc
echo 'echo " ▄▄▄▄    ██▓    ▄▄▄       ▄████▄   ██ ▄█▀    ██░ ██  ▄▄▄     ▄▄▄█████▓"' >> ~/.bashrc
echo 'echo "▓█████▄ ▓██▒   ▒████▄    ▒██▀ ▀█   ██▄█▒    ▓██░ ██▒▒████▄   ▓  ██▒ ▓▒"' >> ~/.bashrc
echo 'echo "▒██▒ ▄██▒██░   ▒██  ▀█▄  ▒▓█    ▄ ▓███▄░    ▒██▀▀██░▒██  ▀█▄ ▒ ▓██░ ▒░"' >> ~/.bashrc
echo 'echo "▒██░█▀  ▒██░   ░██▄▄▄▄██ ▒▓▓▄ ▄██▒▓██ █▄    ░▓█ ░██ ░██▄▄▄▄██░ ▓██▓ ░"' >> ~/.bashrc
echo 'echo "░▒▓███▀▒░ ▒░▓  ░▒▒   ▓▒█░░ ░▒ ▒  ░▒ ▒▒ ▓▒    ▒ ░░▒░▒ ▒▒   ▓▒█░ ▒ ░░"' >> ~/.bashrc
echo 'echo "▒░▒   ░ ░ ░ ▒  ░ ▒   ▒▒ ░  ░  ▒   ░ ░▒ ▒░    ▒ ░▒░ ░  ▒   ▒▒ ░   ░"' >> ~/.bashrc
echo 'echo " ░    ░   ░ ░    ░   ▒   ░        ░ ░░ ░     ░  ░░ ░  ░   ▒    ░"' >> ~/.bashrc
echo 'echo " ░          ░  ░     ░  ░░ ░      ░  ░       ░  ░  ░      ░  ░"' >> ~/.bashrc
echo 'echo "      ░                  ░"' >> ~/.bashrc
echo 'echo -e "\e[0m"' >> ~/.bashrc

echo 'PS1='\''\[\e[1;31m\]┌──(\user㉿\h)-[\w]\n\[\e[1;31m\]└─$\[\e[0m\] '\'' ' >> ~/.bashrc
