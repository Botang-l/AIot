# AIoT Docker Base

## Table of Contents
- [Host 檔案架構](#host-檔案架構)
- [Container 檔案架構](#container-檔案架構)
- [環境設定參數](#環境設定參數)
- [Python Module List](#python-module-list)
- [一般環境](#一般環境)



## Host 檔案架構
```bash
AIoT Docker Base
    ├── env_setup.sh            # environment variables
    ├── run.sh                  # environment setup script
    ├── run-docker.sh           # docker run script without nginx
    ├── Docker/
    │   ├── docker-compose.yml
    │   ├── Dockerfile
    │   ├── requirements.txt    # python module list
    │   └── start.sh            # container entrypoint
```


## Container 檔案架構
```bash
workspace/
    ├── projects/       # ALL repos without flask
```


