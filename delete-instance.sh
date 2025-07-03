#!/bin/bash

aws ec2 terminate-instances \
## ur instance id will be input 
  --instance-ids i-38231ea3228f5a28  \ 
    --region us-east-1
