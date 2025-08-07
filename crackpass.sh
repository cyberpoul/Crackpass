#!/bin/bash

echo "*************************************************"
echo "*                                               *"
echo "*                Crack Password Script          *"
echo "*                     by opscur                 *"
echo "*       https://github.com/cyperpoul/Crackpass  *"
echo "*                                               *"
echo "*************************************************"

if [ $# -ne 1 ]; then
  echo "Usage : $0 <fichier.rar, fichier.zip, fichier.docx, fichier.xlsx ou fichier.pdf>"
  exit 1
fi

fichier="$1"
extension="${fichier##*.}"

if [ "$extension" == "rar" ]; then
  rar2john "$fichier" > hash
  john --wordlist=/usr/share/wordlists/rockyou.txt hash
elif [ "$extension" == "zip" ]; then
  zip2john "$fichier" > hash
  john --wordlist=/usr/share/wordlists/rockyou.txt hash
elif [ "$extension" == "pdf" ]; then
  pdf2john "$fichier" > hash
  john --wordlist=/usr/share/wordlists/rockyou.txt hash
elif [ "$extension" == "docx" ] || [ "$extension" == "xlsx" ]; then
  office2john "$fichier" > hash
  john --wordlist=/usr/share/wordlists/rockyou.txt hash
else
  echo "Extension de fichier non supportée : $extension"
  exit 1
fi

rm -f hash
