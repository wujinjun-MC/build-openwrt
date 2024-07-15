# cd /tmp
# wget -q https://www.cpolar.com/static/downloads/releases/3.3.18/cpolar-stable-linux-amd64.zip -O cpolar.zip && unzip cpolar.zip
curl -sL https://git.io/cpolar | sed '/download_cpolar() {/a RELEASE_VERSION=latest' | sudo bash
mkdir -p ~/.ssh
echo "$MY_SSH_PUB_KEY" >> ~/.ssh/authorized_keys
echo "Starting tunnel..."
cpolar authtoken "$MY_REVERSE_PROXY_TOKEN"
echo "Pleased wait and check tcp tunnel on your dashboard at https://dashboard.cpolar.com/status"
echo "Remove /tmp/keep-term to continue"
cpolar tcp 22 -daemon on -log ~/test.log -log-level INFO &# tail -F ~/test.log &
if [ "$1"x != "nonblock"x ]
then
    KEEPALIVE_FLAG_FILE=$(mktemp)
    touch "$KEEPALIVE_FLAG_FILE"
    echo "Remove $KEEPALIVE_FLAG_FILE to continue"
    while true
    do
        if ! [[ -f "$KEEPALIVE_FLAG_FILE" ]]
        then
            break
        fi
        sleep 10
    done
fi
