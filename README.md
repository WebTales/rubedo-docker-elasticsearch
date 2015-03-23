# rubedo-docker-elasticsearch
Launch 2nd after rubedo-docker-data:
sudo docker run --name test_elasticsearch -p IP:9003:9001 --restart="always" -d webtales/rubedo-docker-elasticsearch