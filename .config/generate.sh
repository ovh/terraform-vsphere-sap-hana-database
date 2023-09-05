#!/bin/bash
terraform-docs . && \
sed -i 's/{<br>/\&emsp;{<br>\&emsp;\&emsp;/g' README.md && \
sed -i 's/},<br>/\&emsp;},<br>/g' README.md && \
sed -i -e 's/[^{]}<br>/\&emsp;}<br>/g' README.md && \
sed -i 's/,<br>/,<br>\&emsp;\&emsp;/g' README.md && \
sed -i 's/,<br>&emsp;&emsp;    &emsp;{/,<br>\&emsp;{/g' README.md && \
sed -i 's/" &emsp;},<br>&emsp;&emsp;/" },<br>\&emsp;/g' README.md && \
sed -i -e 's/{ "id" : 0/\&emsp;{ "id" : 0/g' README.md