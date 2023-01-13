#!/bin/bash
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
apt-get install nodejs -y
cd passbolt_cli
npm install
npm audit fix
npm link

GPG_TTY=/dev/pts/0
export GPG_TTY

cd /passbolt_cli/app/config
cat << EOF > config.json
{
  "domain" : {
    "baseUrl": "https://passbolt.$domain_intra_ba",
    "publicKey" : {
      "fingerprint" : "C2C7884D970723421D0D1ED7936F19C0788EB42D"
    }
  },
  "user" : {
    "firstname": "$USER",
    "lastname" : "surname",
    "email" : "$USER.surname@ext.$domain_pro_ba",
    "privateKey" : {
      "fingerprint": "F7AA078EF78D028DF70666DCC01FB59187BD0722"
    }
  },
  "agentOptions": {
    "rejectUnauthorized": true
  },
  "gpg" : {
    "trust": "always"
  }
}
EOF

echo "Importació clau servidor"
passbolt server-key --domain=https://passbolt.$domain_intra_ba > ./server.key
gpg --import ./server.key
echo ""
echo "Importació clau privada"
gpg --import ./passbolt_private.asc
echo "Importació clau publica"
gpg --import ./passbolt_public.asc

passbolt auth
#passbolt get $(passbolt find  | awk '/Axigen/ { print $NF }') | gpg -q --no-tty
passbolt get $(passbolt find  | awk '/Axigen/ { print $NF }') | gpg -q --no-tty | grep -i "password" >> temp.txt
sed 's/^{\"password\":\"\(.*\)\",\".*/\L\1/' temp.txt >> password.txt
rm temp.txt
cat password.txt

#passbolt server-key --domain=https://passbolt.$domain_intra_ba > ./server.key
#passbolt server-key --fingerprint --domain=https://passbolt.$domain_intra_ba
/bin/bash