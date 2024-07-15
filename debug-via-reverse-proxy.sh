# cd /tmp
# wget -q https://www.cpolar.com/static/downloads/releases/3.3.18/cpolar-stable-linux-amd64.zip -O cpolar.zip && unzip cpolar.zip
curl -sL https://git.io/cpolar | sed '/download_cpolar() {/a RELEASE_VERSION=latest' | sudo bash
mkdir -p ~/.ssh
echo "${{ secrets.SSH_PUBLIC_KEY }}" >> ~/.ssh/authorized_keys
echo "Starting tunnel..."
cpolar authtoken "${{ secrets.REVERSE_PROXY_TOKEN }}"
echo "Pleased wait and check tcp tunnel on your dashboard at https://dashboard.cpolar.com/status"
echo "Remove /tmp/keep-term to continue"
timeout -s 2 5h cpolar tcp 22 -daemon on -log ~/test.log -log-level INFO &
while true
do
    if ! [[ -f /tmp/keep-term ]]
    then
        break
    fi
    sleep 10
done
