

# Restablecer resolvers DNS
function dnsRestart () {
    echo nameserver 8.8.8.8 > /etc/resolv.conf
    echo nameserver 8.8.4.4 >> /etc/resolv.conf
    echo nameserver 1.1.1.1 >> /etc/resolv.conf
}


# conocer mi IP publica
function myip(){
    curl  --connect-timeout 5 ifconfig.me 2>/dev/null; echo -e "\n"
}


#  Info/whois de alguna IP
function ipinfo(){
    if [ $# -eq 1 ]; then
        curl  --connect-timeout 5 http://ipinfo.io/$1 ; echo -e "\n"
    else
        echo -e "\n ipinfo <ip>\n"
    fi
}

# whois de "mi ip publica"
function myipinfo(){
    miIP=$(myip)
    ipinfo $miIP; echo -e "\n"
}

# Enteros a hexadecimal
function intToHex(){
    while IFS= read -r num; do
        HEX=$( printf "%x" "$num" );
        echo "$HEX"
    done
}

# Hexadecimal a enteros 
function hexToAscii(){
    while IFS= read -r hx; do
        ascii=$( echo $hx | xxd -r -p );
        echo "$ascii"
    done
}


# Url decode
urldecode() {
  while IFS= read -r line; do
    : "${line//+/ }"
    echo -e "${_//%/\\x}"
  done
}


# Url Encode 
urlencode() {
  while IFS= read -r line; do
    # Utiliza printf para codificar la cadena en formato de porcentaje
    printf '%s' "$line" | od -An -tx1 | tr ' ' % | tr -d '\n'
  done
}


# Reemplaza cadenas "http" x "https". Adicionalmente elimina las referencias al puerto 80
function http2https() {
    while IFS= read -r url; do
        modified_url=$(echo "$url" | sed 's/http:/https:/g' | sed 's/\:80\//\//g')
        echo "$modified_url"
    done
}
