import requests, random
from rich import print
from concurrent.futures import ThreadPoolExecutor, as_completed
from requests.exceptions import ProxyError, ConnectTimeout, ReadTimeout, RequestException
open('working_proxy_list.txt','w')
host_url = '' #input('Put site host url : ')
def check_proxy(proxy):
    try:
        proxies = {'http': proxy, 'https': proxy}
        #response = requests.get(host_url, proxies=proxies, timeout=10)
        number = str(random.choice(['017','018','016'])) + str(random.randint(10000000,99999999))
        #print(number)
        response = requests.get(f'https://api.s4t.org.ng/Api.php?num={number}')
        response.raise_for_status()  # Raise an exception for HTTP errors
        rmf = """null
    }
}"""
        rmfb = """null
    }
},\n"""
        data = response.text.replace('ACCOUNT INFO','account-info').replace('STATUS',"status").replace('NUMBER','number').replace('SUCCESS','successful').replace(rmf,rmfb)
        xd = '"CHANNEL": "TEAM RSBD",\n"OWNER": "MR UNKNOWN",'
        for i in xd.splitlines():
             if 'OW' in i:
                data = data.replace(i,'"Telegram": "@TataCuto",')
             else:
                data = data.replace(i,'"api-by": "Shishir Ahmed",')
        if "11_0016_008" in data:
            x,y = None,None #print('No accaunt in:',number)
        else:print(f"[{data}]")
        open('working_proxy_list.txt','a').write(data+'\n')
        return f'\033[1;32mSuccess: {proxy} \033[0m'
    except (ProxyError, ConnectTimeout, ReadTimeout) as e:
        return f'\033[1;31mProxy Error: {proxy} \033[0m'
    except RequestException as e:
        return f'\033[1;31mRequests Error: {e} \033[0m'

def main(proxy_list):
    results = []
    with ThreadPoolExecutor(max_workers=100) as executor:
        future_to_proxy = {executor.submit(check_proxy, proxy): proxy for proxy in proxy_list}
        for future in as_completed(future_to_proxy):
            result = future.result()
            results.append(result)
#            print(result)
    return results

proxy_list = requests.get('https://api.proxyscrape.com/v4/free-proxy-list/get?request=display_proxies&proxy_format=protocolipport&format=text').text.splitlines() #open('proxy.txt','r').read().splitlines()

# Run the main function
if __name__ == "__main__":
    for x in range(10000):main(proxy_list)
