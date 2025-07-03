

## Creating AWS Resource with function and array
### 🔹 Short Note: Creating AWS Resources Using Functions and Arrays in Bash

In AWS automation with Bash scripting, **functions** and **arrays** are useful for organizing and repeating tasks such as creating multiple resources.

---

### ✅ **1. Functions**

Functions allow you to group AWS CLI commands into reusable blocks.

**Example:**

```bash
create_s3_bucket() {
  aws s3api create-bucket --bucket "$1" --region eu-west-2
}
```

Call it like:

```bash
create_s3_bucket "my-unique-bucket-name"
```

---

### ✅ **2. Arrays**

Arrays store multiple items (e.g., department names or instance types) that can be looped through.

**Example:**

```bash
departments=("HR" "Sales" "IT")
```

Loop through them:

```bash
for dept in "${departments[@]}"; do
  create_s3_bucket "company-$dept-bucket"
done
```

---

### ✅ **Combined Example**

```bash
create_s3_buckets() {
  company="datawise"
  departments=("Marketing" "Sales" "HR")
  for dept in "${departments[@]}"; do
    bucket_name="${company}-${dept}-bucket"
    aws s3api create-bucket --bucket "$bucket_name" --region eu-west-2
    echo "Created: $bucket_name"
  done
}
```

Call the function:

```bash
create_s3_buckets
```

---

### 📝 Summary

* **Functions** encapsulate logic for reuse.
* **Arrays** handle multiple values efficiently.
* This combo simplifies bulk AWS resource creation like S3 buckets, EC2s, etc.

#### Getting the Documentation CLI command to use to create, delete, check logs etc.
we can go to [amazon-cli](https://docs.aws.amazon.com/cli/latest/reference/ec2/)

From example lets say we want to check the ec2 instance command on Cli so we can use window + F to find ec2 then click it
![caption](/img/1.document-page-ec2.jpg)

We can see a bunch of things we use ec2 for. For example to run an instance we can also search for instance.
![caption](/img/2.search-on-ec2.jpg)

Then go to example to show how we can use the command
![caption](/img/3.examples.jpg)

And the output will be giving as json
![caption](/img/4.output.jpg)

The below is example for s3-bucket we can follow the step for ec2 by also going to the example to see how it is use.

![caption](/img/5.document-s3.jpg)
running this script [create-bucket](/s3-bucket.sh). see https://github.com/Heebrah/S3-bucket-AWS for how to create s3-bucket on the console.
![caption](/img/6.creating-s3-bucket.jpg)

### writing multiple commands on script to run
1. first we configure our aws using ``aws configure``

2. then input our access and secret key

3. write the command in the bash script as function 

4. then give it permission with chmod +x **filename**

5 this will run automatically if your input are correct

## lets try this script below by changing some values to our own values

### ✅ **Corrected and Enhanced Script**

```bash
#!/bin/bash

# Function to create EC2 instances
create_ec2_instances() {
    # Specify parameters
    instance_type="t2.micro"
    ami_id="ami-0cd59ecaf368e5ccf"  # Amazon Linux 2 AMI in eu-west-2
    count=2
    key_name="MyKeyPair"
    security_group_id="sg-0123456789abcdef0"   # Replace with your SG ID
    subnet_id="subnet-0123456789abcdef0"       # Replace with your Subnet ID
    region="eu-west-2"

    # Run EC2 instance creation
    aws ec2 run-instances \
        --image-id "$ami_id" \
        --instance-type "$instance_type" \
        --count $count \
        --key-name "$key_name" \
        --security-group-ids "$security_group_id" \
        --subnet-id "$subnet_id" \
        --region "$region" \
        --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=AutomatedEC2}]'

    # Check for success
    if [ $? -eq 0 ]; then
        echo "✅ EC2 instances created successfully."
    else
        echo "❌ Failed to create EC2 instances."
    fi
}

# Call the function
create_ec2_instances
```

---

## 📝 Notes:

* ✅ Use `--region` to make sure the command targets the right AWS region.
* ✅ Make sure you replace:

  * `MyKeyPair` with your actual **EC2 key pair name**
  * `sg-0123...` with your actual **Security Group ID**
  * `subnet-0123...` with your actual **Subnet ID**
* ✅ Ensure AWS CLI is **configured** with `aws configure`.
you can also go through this code and edit to your own configuration
[create-instance-bucket](/bucket_Dept.sh)



