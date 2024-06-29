
# Utilidades varias 

---
## [01] function "dnsRestart()" 
UTILIDAD: Restablecer resolvers DNS  
CODE:  
```bash
# requiere privilegios de lectura sobre /etc/resolv.conf
function dnsRestart () {
    echo nameserver 8.8.8.8 > /etc/resolv.conf
    echo nameserver 8.8.4.4 >> /etc/resolv.conf
    echo nameserver 1.1.1.1 >> /etc/resolv.conf
}
```
---
## [02] function "myip()" 
UTILIDAD: conocer mi IP publica  
CODE:  
```bash
function myip(){
    curl  --connect-timeout 5 ifconfig.me 2>/dev/null; echo -e "\n"
}
```
---
## [03] function "ipinfo()"  
UTILIDAD: Info/whois de alguna IP  
CODE:  
```bash
function ipinfo(){
    if [ $# -eq 1 ]; then
        curl  --connect-timeout 5 http://ipinfo.io/$1 ; echo -e "\n"
    else
        echo -e "\n ipinfo <ip>\n"
    fi
}
```
----
## [04] function "myipinfo()"  
UTILIDAD: whois de "mi ip publica"  
CODE:  
```bash
function myipinfo(){
    miIP=$(myip)
    ipinfo $miIP; echo -e "\n"
}
```
---
## [05] function "intToHex()"  
UTILIDAD: Enteros a Hexadecimal  
USO: `$ echo 123 | intToHex `
CODE:  
```bash
function intToHex(){
    while IFS= read -r num; do
        HEX=$( printf "%x" "$num" );
        echo "$HEX"
    done
}
```
---
## [06] function "hexToAscii()"  
UTILIDAD: Enteros a Hexadecimal  
USO: `$ echo 66 | hexToAscii `  
CODE:  
```bash
function hexToAscii(){
    while IFS= read -r hx; do
        ascii=$( echo $hx | xxd -r -p );
        echo "$ascii"
    done
}
```

## [07] function "urldecode()"  
UTILIDAD: "Url decode"  
USO: `$ echo 'http%3A//example.com/poc%3Fid%3D123%26role%3D1001' | urldecode `  
output: `http://example.com/poc?id=123&role=100`  
CODE:  
```bash
urldecode() {
  while IFS= read -r line; do
    : "${line//+/ }"
    echo -e "${_//%/\\x}"
  done
}
```
---

## [08] function "urlencode()"  
UTILIDAD: "Url Encode"  
USO: `$ echo "https://example.com/" | urlencode `
output: `%68%74%74%70%73%3a%2f%2f%65%78%61%6d%70%6c%65%2e%63%6f%6d%2f`  
CODE:  
```bash
urlencode() {
  while IFS= read -r line; do
    # Utiliza printf para codificar la cadena en formato de porcentaje
    printf '%s' "$line" | od -An -tx1 | tr ' ' % | tr -d '\n'
  done
}

```
---

## [08] function "http2https()"  
UTILIDAD: Reemplaza cadenas "http" x "https". Adicionalmente elimina las referencias al puerto 80  
USO: `$ echo 'http://example.com/' | http2https `  
output: `$ https://example.com/`  
CODE:  
```bash
function http2https() {
    while IFS= read -r url; do
        modified_url=$(echo "$url" | sed 's/http:/https:/g' | sed 's/\:80\//\//g')
        echo "$modified_url"
    done
}

```
---
