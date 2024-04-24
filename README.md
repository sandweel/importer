## Automated script for downloading Magento 1/2 media/all files and database
#### Script usage
```
Usage: bash ./importer.sh [media|public|sql|both|ssh] [server ip address] [ssh port (default 22)]

media - copying media files in archive to the local node
public - copying root project directory (public_html) in archive to the local node
sql - create sql dump and download to the local node
both - download media and sql dump to the local node
ssh - copy ssh public key to the remote node

	Examples: /bin/bash ./importer.sh media test.com
		  /bin/bash ./importer.sh sql test.com 2288
```
