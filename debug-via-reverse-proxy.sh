# cd /tmp
# wget -q https://www.cpolar.com/static/downloads/releases/3.3.18/cpolar-stable-linux-amd64.zip -O cpolar.zip && unzip cpolar.zip
if ! which cpolar
then
    while ! curl -sL https://git.io/cpolar | sed '/download_cpolar() {/a RELEASE_VERSION=latest' | sudo bash
    then
        sleep 5
    fi
fi
mkdir -p ~/.ssh
echo "$MY_SSH_PUB_KEY" >> ~/.ssh/authorized_keys
echo "Starting tunnel..."
env > ~/current_env.txt
cpolar authtoken "$MY_REVERSE_PROXY_TOKEN"
echo "Pleased wait and check tcp tunnel on your dashboard at https://dashboard.cpolar.com/status"
# echo "Remove /tmp/keep-term to continue"
cpolar tcp 22 -daemon on -log /tmp/cpolar.log -log-level INFO &# tail -F ~/test.log &
if [ "$1"x != "nonblock"x ]
then
    if ! [[ -f /tmp/keep-term ]]
    then
        export KEEPALIVE_FLAG_FILE=/tmp/keep-term
    else
        export KEEPALIVE_FLAG_FILE=$(mktemp)
    fi
    touch "$KEEPALIVE_FLAG_FILE"
    echo "Remove $KEEPALIVE_FLAG_FILE to continue"
    echo "echo Remove $KEEPALIVE_FLAG_FILE to stop blocking next step"  >> ~/.bash_profile
    while true
    do
        if ! [[ -f "$KEEPALIVE_FLAG_FILE" ]]
        then
            break
        fi
        sleep 10
    done
fi
