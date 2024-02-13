#!/bin/bash
cat > index.html <<E0F
<h1>Hello World</h1>
E0F

nohup busybox httpd -f -p ${web_port} &