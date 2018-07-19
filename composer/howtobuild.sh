cd "$(dirname "$0")"

PEER1="192.168.1.222"
PEER2="192.168.1.224"
PEER3="192.168.1.224"
PEER4="192.168.1.224"
PEER5="192.168.1.224"
ORDERER0="192.168.1.224"
ORDERER1="192.168.1.224"
ORDERER2="192.168.1.224"
KAFKA1="192.168.1.224"
KAFKA2="192.168.1.224"
KAFKA3="192.168.1.224"
KAFKA4="192.168.1.224"
ZKEEPER1="192.168.1.224"
ZKEEPER2="192.168.1.224"
ZKEEPER3="192.168.1.224"

sed -i -e "s/{IP-HOST-2}/$PEER2/g" ../createPeerAdminCard.sh
sed -i -e "s/{IP-HOST-2}/$PEER2/g" ../createPeerAdminCard.sh

cryptogen generate --config=./crypto-config.yaml
export FABRIC_CFG_PATH=$PWD
configtxgen -profile ComposerOrdererGenesis -outputBlock ./composer-genesis.block
configtxgen -profile ComposerChannel -outputCreateChannelTx ./composer-channel.tx -channelID composerchannel

ORG1KEY="$(ls crypto-config/peerOrganizations/org1.example.com/ca/ | grep 'sk$')"
ORG2KEY="$(ls crypto-config/peerOrganizations/org2.example.com/ca/ | grep 'sk$')"
ORG3KEY="$(ls crypto-config/peerOrganizations/org3.example.com/ca/ | grep 'sk$')"
ORG4KEY="$(ls crypto-config/peerOrganizations/org4.example.com/ca/ | grep 'sk$')"
ORG5KEY="$(ls crypto-config/peerOrganizations/org5.example.com/ca/ | grep 'sk$')"

sed -i -e "s/{ORG1-CA-KEY}/$ORG1KEY/g" docker-compose.yml
sed -i -e "s/{ORG2-CA-KEY}/$ORG2KEY/g" docker-compose-peer2.yml
sed -i -e "s/{ORG3-CA-KEY}/$ORG3KEY/g" docker-compose-peer3.yml
sed -i -e "s/{ORG4-CA-KEY}/$ORG4KEY/g" docker-compose-peer4.yml
sed -i -e "s/{ORG5-CA-KEY}/$ORG5KEY/g" docker-compose-peer5.yml

