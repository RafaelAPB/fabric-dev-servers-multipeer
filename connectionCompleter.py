import getopt, sys,json

def help():
    print('Connection Profile creator for HLFv1');
    print('This creator assumes each peer to be on a different machine,')
    print('thus a connection profile is created for each peer/orderer configured.')
    print('')
    print(' Options: ')
    print(' --help  Displays this message.')
    print(' --name=<name of network>  Name of the network')
    print(' --orderers=<nr> Specifies the number of orderers')
    print(' --orgs=<nr> Specifies the number of organizations')
    print(' --peers=<nr> Specifies the number of peers on each organization')

def replaceConfigIps(configPath,ipPath,outPath):
    with open(ipPath,'r') as ip_data, open(configPath,'r') as templateFile:
        template = json.load(templateFile)
        ipList = json.load(ip_data)

        for url in ipList.keys():
            print(url)
            print('ta')
            print(ipList[url])



unixOptions = "hico"
gnuOptions = ["help", "ips=", "config=","out="]

argumentList = sys.argv[1:]

try:
    arguments, values = getopt.getopt(argumentList, unixOptions, gnuOptions)
except getopt.error as err:
    # output error, and return with an error code
    print (str(err))
    sys.exit(2)


ipPath = ''
configPath = ''
outPath = ''

# evaluate given options
for currentArgument, currentValue in arguments:
    if currentArgument in ("-h", "--help"):
        help()
    elif currentArgument in ("-i", "--ips"):
        ipPath = currentValue
    elif currentArgument in ("-c", "--config"):
        configPath = currentValue
    elif currentArgument in ("-o", "--out"):
        outPath = currentValue

replaceConfigIps(configPath,ipPath,outPath)