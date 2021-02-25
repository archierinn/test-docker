# Test Docker

## How to
- Clone this repository
- Run this script:
    ```bash
    cd test-docker
    sudo docker-compose up
    ```
- Wait until service status done
- Now, you can go to `localhost:8004/install` to install boxbilling
- Checked the `I agree` checkbox and click next
- When setting database, set it like this and click next
    Database server/host: **db**
    Database name: **boxbilling**
    Database user: **root**
    Database password: **root**
- If an error occured when trying to connect to database, you can go to `localhost:8080` first and login using credential above (*except the database name*)
- If the database has been connected, you will set the administrator of the boxbilling. After finished setting the administrator, you can click next.
- There will be some confirmation dialog, click yes or OK and wait until done.
- After the installation succeed, you must remove the `/install` folder.
- To remove the `/install` folder, open another terminal and head to `test-docker` folder run this script:
    ```bash
    sudo docker exec test-docker_web_1 rm -rf install
    ```
- Now you can go to client area and admin area in boxbilling.
- To stop the docker, run this script:
    ```bash
    sudo docker-compose down
    ```
- Enjoy!

## LICENSE
MIT