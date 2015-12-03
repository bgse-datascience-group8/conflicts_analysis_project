# Deploy Guide

1. Launch an m3.xlarge using ami-382cf64b (bitnami-nodejs-5.1.0-0-linux-ubuntu-14.04.1-x86_64-hvm-ebs)
2. Ensure port 3000 is open
3. ssh
4. `git clone https://github.com/bgse-datascience-group8/conflicts_analysis_project`
5. `cd conflicts_analysis_project/conflict_analysis_app`
6. 
    ```sh
    wget https://s3-eu-west-1.amazonaws.com/abarciauskas-bgse/events.zip
    unzip events.zip
    mkdir public/javascripts/events
    mv events/* public/javascripts/events/
    ```

7. `npm install`
8. `nohup node app.js > output.log &`

## Todo

* Remove 2013-05-13 & 2013-05-14
* Fix size of circles
