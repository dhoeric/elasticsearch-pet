#!/bin/bash
chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data;
su elasticsearch -c "/bin/bash es-docker"
