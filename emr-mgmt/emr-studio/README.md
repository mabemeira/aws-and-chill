cd emr-mgmt/emr-studio

docker build -t emr-mgmt-emr-studio-terraform-image:latest .

docker run -dit --name emr-mgmt-emr-studio -v $(pwd):/emr-mgmt/emr-studio emr-mgmt-emr-studio-terraform-image:latest /bin/bash

docker exec -it emr-mgmt-emr-studio bash

terraform version
aws --version
aws configure

terraform init
terraform plan
terraform apply