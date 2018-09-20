cd "$(dirname "$0")"

HOST0=""
HOST1=""
HOST2=""
HOST3=""
HOST4=""

PEER0=$HOST0" peer0.org1.example.com"
PEER1=$HOST1" peer1.org1.example.com"
PEER2=$HOST2" peer2.org1.example.com"
PEER3=$HOST3" peer3.org1.example.com"
PEER4=$HOST4" peer4.org1.example.com"

ORDERER0=$HOST1" orderer0.example.com"
ORDERER1=$HOST2" orderer1.example.com"
ORDERER2=$HOST3" orderer2.example.com"

ZKEEP0=$HOST1" zookeeper0.example.com"
ZKEEP1=$HOST3" zookeeper1.example.com"
ZKEEP2=$HOST4" zookeeper2.example.com"

KAFKA0=$HOST0" kafka0.example.com"
KAFKA1=$HOST0" kafka1.example.com"
KAFKA2=$HOST0" kafka2.example.com"
KAFKA3=$HOST0" kafka3.example.com"

sed -i -e "s/{HOST-0}/$HOST0/g" ../createPeerAdminCard.sh
sed -i -e "s/{HOST-1}/$HOST1/g" ../createPeerAdminCard.sh
sed -i -e "s/{HOST-2}/$HOST2/g" ../createPeerAdminCard.sh
sed -i -e "s/{HOST-3}/$HOST3/g" ../createPeerAdminCard.sh
sed -i -e "s/{HOST-4}/$HOST4/g" ../createPeerAdminCard.sh

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

sudo echo $PEER0 >> /etc/hosts
sudo echo $PEER1 >> /etc/hosts
sudo echo $PEER2 >> /etc/hosts
sudo echo $PEER3 >> /etc/hosts
sudo echo $ORDERER0 >> /etc/hosts
sudo echo $ORDERER1 >> /etc/hosts
sudo echo $ORDERER2 >> /etc/hosts
sudo echo $ZKEEP0 >> /etc/hosts
sudo echo $ZKEEP1 >> /etc/hosts
sudo echo $ZKEEP2 >> /etc/hosts
sudo echo $KAFKA0 >> /etc/hosts
sudo echo $KAFKA1 >> /etc/hosts
sudo echo $KAFKA2 >> /etc/hosts
sudo echo $KAFKA3 >> /etc/hosts
